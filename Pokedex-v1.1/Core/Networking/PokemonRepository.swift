import Foundation

struct PokemonIndexEntry: Sendable {
    let id: Int
    let name: String
}

actor PokemonRepository {
    static let shared = PokemonRepository()
    private static let indexedPokemonRange = 1...1025

    private let client: any PokeAPIClient
    private var cachedIndex: [PokemonIndexEntry]?
    private var cachedPokemonByID: [Int: Pokemon] = [:]
    private var cachedSupplementalByPokemonID: [Int: PokemonSupplementalData] = [:]
    private var cachedDamageRelationsByTypeURL: [String: DamageRelations] = [:]

    init(client: any PokeAPIClient = NativePokeAPIClient()) {
        self.client = client
    }

    func pokemonIndex() async throws -> [PokemonIndexEntry] {
        if let cachedIndex {
            return cachedIndex
        }

        let decoded = try await client.fetchPokemonIndex(limit: 1025)

        let index = decoded.results.compactMap { item -> PokemonIndexEntry? in
            guard let id = Self.pokemonID(from: item.url) else { return nil }
            return PokemonIndexEntry(id: id, name: item.name)
        }
        .sorted { $0.id < $1.id }

        cachedIndex = index
        return index
    }

    func pokemon(name: String) async throws -> Pokemon {
        let query = name
            .lowercased()
            .trimmingCharacters(in: .whitespacesAndNewlines)

        if let id = Int(query) {
            return try await pokemon(id: id)
        }

        if let cached = cachedPokemonByID.values.first(where: { $0.name == query }),
           Self.isComplete(cached) {
            return cached
        }

        let pokemon = try await client.fetchPokemon(name: query)
        cachedPokemonByID[pokemon.id] = pokemon
        return pokemon
    }

    func pokemon(id: Int) async throws -> Pokemon {
        if let cached = cachedPokemonByID[id],
           Self.isComplete(cached) {
            return cached
        }

        let pokemon = try await client.fetchPokemon(id: id)
        cachedPokemonByID[id] = pokemon
        return pokemon
    }

    func regionPokemons(region: Region) async throws -> [Pokemon] {
        let index = try await pokemonIndex()
        return index
            .filter { region.pokedexRange.contains($0.id) }
            .map { entry in
                if let cached = cachedPokemonByID[entry.id] {
                    return cached
                }

                let placeholder = Self.placeholderPokemon(id: entry.id, name: entry.name)
                cachedPokemonByID[entry.id] = placeholder
                return placeholder
            }
    }

    func supplementalData(for pokemon: Pokemon) async throws -> PokemonSupplementalData {
        if let cached = cachedSupplementalByPokemonID[pokemon.id] {
            return cached
        }

        let speciesURLString = pokemon.species?.url
            ?? "https://pokeapi.co/api/v2/pokemon-species/\(pokemon.id)/"
        guard let speciesURL = URL(string: speciesURLString) else {
            throw URLError(.badURL)
        }

        let species = try await client.fetchSpecies(url: speciesURL)

        let description = Self.cleanedFlavorText(from: species.flavor_text_entries)
        let evolutionChain = try await fetchEvolutionChain(from: species.evolution_chain.url)
        let specialForms = try await fetchSpecialForms(from: species.varieties, baseName: pokemon.name)
        let shinyArtworkURL =
            pokemon.sprites.other?.officialArtwork?.front_shiny
            ?? pokemon.sprites.front_shiny

        let supplemental = PokemonSupplementalData(
            description: description,
            evolutionChain: evolutionChain,
            shinyArtworkURL: shinyArtworkURL,
            specialForms: specialForms
        )

        cachedSupplementalByPokemonID[pokemon.id] = supplemental
        return supplemental
    }

    func damageRelations(for pokemon: Pokemon) async throws -> [DamageRelations] {
        var relations: [DamageRelations] = []

        for entry in pokemon.types {
            if let cached = cachedDamageRelationsByTypeURL[entry.type.url] {
                relations.append(cached)
                continue
            }

            guard let url = URL(string: entry.type.url) else { continue }
            let response = try await client.fetchType(url: url)
            cachedDamageRelationsByTypeURL[entry.type.url] = response.damage_relations
            relations.append(response.damage_relations)
        }

        return relations
    }

    func prefetchAdjacentDetails(around id: Int) async {
        let previousID = id - 1
        let nextID = id + 1

        async let previousPrefetch: Void = prefetchDetailIfNeeded(id: previousID)
        async let nextPrefetch: Void = prefetchDetailIfNeeded(id: nextID)

        _ = await (previousPrefetch, nextPrefetch)
    }

    private static func placeholderPokemon(id: Int, name: String) -> Pokemon {
        Pokemon(
            id: id,
            name: name,
            types: [],
            sprites: PokemonSprites(
                front_default: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png",
                front_shiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/\(id).png",
                other: OtherSprites(
                    officialArtwork: OfficialArtwork(
                        front_default: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(id).png",
                        front_shiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/shiny/\(id).png"
                    )
                )
            ),
            stats: [],
            species: PokemonSpeciesReference(
                name: name,
                url: "https://pokeapi.co/api/v2/pokemon-species/\(id)/"
            )
        )
    }

    private static func isComplete(_ pokemon: Pokemon) -> Bool {
        !pokemon.types.isEmpty && !pokemon.stats.isEmpty
    }

    private static func pokemonID(from url: String) -> Int? {
        let components = url.split(separator: "/").filter { !$0.isEmpty }
        guard let value = components.last else { return nil }
        return Int(value)
    }

    private func fetchEvolutionChain(from urlString: String) async throws -> [Pokemon] {
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let response = try await client.fetchEvolutionChain(url: url)
        let names = Self.flattenEvolutionChain(response.chain)

        var pokemons: [Pokemon] = []
        for name in names {
            let pokemon = try await pokemon(name: name)
            pokemons.append(pokemon)
        }

        return pokemons
    }

    private func fetchSpecialForms(
        from varieties: [PokemonVariety],
        baseName: String
    ) async throws -> [PokemonSpecialForm] {
        let supportedVarieties = varieties.filter {
            !$0.is_default && Self.isSupportedSpecialForm($0.pokemon.name)
        }

        var forms: [PokemonSpecialForm] = []
        for variety in supportedVarieties {
            let pokemon = try await pokemon(name: variety.pokemon.name)
            forms.append(
                PokemonSpecialForm(
                    title: Self.formattedSpecialFormTitle(
                        from: variety.pokemon.name,
                        baseName: baseName
                    ),
                    pokemon: pokemon
                )
            )
        }

        return forms
    }

    private static func flattenEvolutionChain(_ node: EvolutionChainLink) -> [String] {
        var orderedNames: [String] = []
        var visited = Set<String>()

        func visit(_ current: EvolutionChainLink) {
            if visited.insert(current.species.name).inserted {
                orderedNames.append(current.species.name)
            }

            current.evolves_to.forEach(visit)
        }

        visit(node)
        return orderedNames
    }

    private static func cleanedFlavorText(from entries: [FlavorTextEntry]) -> String? {
        let preferredEntry = entries.reversed().first { $0.language.name == "es" }
            ?? entries.first { $0.language.name == "es" }
            ?? entries.reversed().first { $0.language.name == "en" }
            ?? entries.first { $0.language.name == "en" }

        return preferredEntry?.flavor_text
            .replacingOccurrences(of: "\n", with: " ")
            .replacingOccurrences(of: "\u{000C}", with: " ")
            .replacingOccurrences(of: "  ", with: " ")
            .trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private static func isSupportedSpecialForm(_ name: String) -> Bool {
        name.contains("-mega") || name.hasSuffix("-gmax")
    }

    private static func formattedSpecialFormTitle(from name: String, baseName: String) -> String {
        let trimmedName = name
            .replacingOccurrences(of: "\(baseName)-", with: "")
            .replacingOccurrences(of: "-", with: " ")
            .capitalized

        if trimmedName == "Gmax" {
            return "Gigantamax"
        }

        if trimmedName.hasPrefix("Mega ") || trimmedName == "Mega" {
            return trimmedName
        }

        return trimmedName
    }

    private func prefetchDetailIfNeeded(id: Int) async {
        guard Self.indexedPokemonRange.contains(id) else { return }

        do {
            let pokemon = try await pokemon(id: id)
            async let supplemental: PokemonSupplementalData = supplementalData(for: pokemon)
            async let relations: [DamageRelations] = damageRelations(for: pokemon)
            _ = try await (supplemental, relations)
        } catch {
            // Ignore prefetch errors to avoid affecting the current detail flow.
        }
    }
}

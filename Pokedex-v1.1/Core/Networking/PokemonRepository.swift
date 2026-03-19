import Foundation

struct PokemonIndexEntry: Sendable {
    let id: Int
    let name: String
}

actor PokemonRepository {
    static let shared = PokemonRepository()

    private var cachedIndex: [PokemonIndexEntry]?
    private var cachedPokemonByID: [Int: Pokemon] = [:]

    func pokemonIndex() async throws -> [PokemonIndexEntry] {
        if let cachedIndex {
            return cachedIndex
        }

        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=1025") else {
            return []
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        let decoded = try JSONDecoder().decode(PokemonIndexResponse.self, from: data)

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

        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(query)") else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        let pokemon = try await MainActor.run {
            try JSONDecoder().decode(Pokemon.self, from: data)
        }
        cachedPokemonByID[pokemon.id] = pokemon
        return pokemon
    }

    func pokemon(id: Int) async throws -> Pokemon {
        if let cached = cachedPokemonByID[id],
           Self.isComplete(cached) {
            return cached
        }

        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(id)") else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        let pokemon = try await MainActor.run {
            try JSONDecoder().decode(Pokemon.self, from: data)
        }
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

    private static func placeholderPokemon(id: Int, name: String) -> Pokemon {
        Pokemon(
            id: id,
            name: name,
            types: [],
            sprites: PokemonSprites(
                front_default: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png",
                other: OtherSprites(
                    officialArtwork: OfficialArtwork(
                        front_default: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(id).png"
                    )
                )
            ),
            stats: []
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
}

private struct PokemonIndexResponse: Decodable {
    let results: [PokemonIndexItem]
}

private struct PokemonIndexItem: Decodable {
    let name: String
    let url: String
}

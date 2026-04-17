import XCTest
@testable import Pokedex_v1_1

final class PokemonRepositoryTests: XCTestCase {
    func testPokemonIndexParsesIDsSortsThemAndCachesTheResponse() async throws {
        let client = MockPokeAPIClient()
        client.indexResponse = PokeAPIIndexResponse(results: [
            PokeAPIIndexItem(name: "venusaur", url: "https://pokeapi.co/api/v2/pokemon/3/"),
            PokeAPIIndexItem(name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/"),
            PokeAPIIndexItem(name: "ivysaur", url: "https://pokeapi.co/api/v2/pokemon/2/")
        ])

        let repository = PokemonRepository(client: client)

        let firstLoad = try await repository.pokemonIndex()
        let secondLoad = try await repository.pokemonIndex()

        XCTAssertEqual(firstLoad.map(\.id), [1, 2, 3])
        XCTAssertEqual(firstLoad.map(\.name), ["bulbasaur", "ivysaur", "venusaur"])
        XCTAssertEqual(secondLoad.map(\.id), [1, 2, 3])
        XCTAssertEqual(client.fetchPokemonIndexCallCount, 1)
    }

    func testRegionPokemonsCreatesPlaceholdersForTheSelectedRegion() async throws {
        let client = MockPokeAPIClient()
        client.indexResponse = PokeAPIIndexResponse(results: [
            PokeAPIIndexItem(name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/"),
            PokeAPIIndexItem(name: "ivysaur", url: "https://pokeapi.co/api/v2/pokemon/2/"),
            PokeAPIIndexItem(name: "chikorita", url: "https://pokeapi.co/api/v2/pokemon/152/")
        ])

        let repository = PokemonRepository(client: client)

        let pokemons = try await repository.regionPokemons(region: Region(name: "Kanto", pokedexRange: 1...151))

        XCTAssertEqual(pokemons.map(\.id), [1, 2])
        XCTAssertTrue(pokemons.allSatisfy { $0.types.isEmpty })
        XCTAssertEqual(
            pokemons.first?.sprites.other?.officialArtwork?.front_default,
            "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png"
        )
    }

    func testSupplementalDataUsesSpanishFlavorTextAndSupportedForms() async throws {
        let client = MockPokeAPIClient()
        let basePokemon = makePokemon(id: 6, name: "charizard")
        let megaPokemon = makePokemon(id: 10034, name: "charizard-mega-x")
        let gmaxPokemon = makePokemon(id: 10195, name: "charizard-gmax")
        let ignoredPokemon = makePokemon(id: 10000, name: "charizard-totem")

        client.speciesResponses["https://pokeapi.co/api/v2/pokemon-species/6/"] = PokemonSpeciesResponse(
            flavor_text_entries: [
                FlavorTextEntry(
                    flavor_text: "Spits fire that is hot enough to melt boulders.",
                    language: NamedAPIResource(name: "en", url: "en"),
                    version: NamedAPIResource(name: "red", url: "red")
                ),
                FlavorTextEntry(
                    flavor_text: "Escupe fuego\nmuy caliente.",
                    language: NamedAPIResource(name: "es", url: "es"),
                    version: NamedAPIResource(name: "scarlet", url: "scarlet")
                )
            ],
            evolution_chain: APIResourceURL(url: "https://pokeapi.co/api/v2/evolution-chain/2/"),
            varieties: [
                PokemonVariety(is_default: true, pokemon: NamedAPIResource(name: "charizard", url: "charizard")),
                PokemonVariety(is_default: false, pokemon: NamedAPIResource(name: "charizard-mega-x", url: "mega")),
                PokemonVariety(is_default: false, pokemon: NamedAPIResource(name: "charizard-gmax", url: "gmax")),
                PokemonVariety(is_default: false, pokemon: NamedAPIResource(name: "charizard-totem", url: "totem"))
            ]
        )
        client.evolutionChainResponses["https://pokeapi.co/api/v2/evolution-chain/2/"] = EvolutionChainResponse(
            chain: EvolutionChainLink(
                species: NamedAPIResource(name: "charmander", url: "1"),
                evolves_to: [
                    EvolutionChainLink(
                        species: NamedAPIResource(name: "charmeleon", url: "2"),
                        evolves_to: [
                            EvolutionChainLink(
                                species: NamedAPIResource(name: "charizard", url: "3"),
                                evolves_to: []
                            )
                        ]
                    )
                ]
            )
        )
        client.pokemonByName["charmander"] = makePokemon(id: 4, name: "charmander")
        client.pokemonByName["charmeleon"] = makePokemon(id: 5, name: "charmeleon")
        client.pokemonByName["charizard"] = basePokemon
        client.pokemonByName["charizard-mega-x"] = megaPokemon
        client.pokemonByName["charizard-gmax"] = gmaxPokemon
        client.pokemonByID[6] = basePokemon

        let repository = PokemonRepository(client: client)

        let supplemental = try await repository.supplementalData(for: basePokemon)

        XCTAssertEqual(supplemental.description, "Escupe fuego muy caliente.")
        XCTAssertEqual(supplemental.evolutionChain.map(\.name), ["charmander", "charmeleon", "charizard"])
        XCTAssertEqual(supplemental.specialForms.map(\.title), ["Mega X", "Gigantamax"])
        XCTAssertEqual(supplemental.specialForms.map(\.pokemon.name), ["charizard-mega-x", "charizard-gmax"])
        XCTAssertEqual(client.fetchSpeciesCallCount, 1)
    }

    func testDamageRelationsAreCachedByTypeURL() async throws {
        let client = MockPokeAPIClient()
        let electricURL = "https://pokeapi.co/api/v2/type/13/"
        let electricType = PokemonTypeEntry(slot: 1, type: PokemonType(name: "electric", url: electricURL))
        let pokemonA = makePokemon(id: 25, name: "pikachu", types: [electricType])
        let pokemonB = makePokemon(id: 26, name: "raichu", types: [electricType])

        client.typeResponses[electricURL] = TypeResponse(
            damage_relations: DamageRelations(
                double_damage_from: [NamedAPIResource(name: "ground", url: "ground")],
                half_damage_from: [NamedAPIResource(name: "electric", url: "electric")],
                no_damage_from: []
            )
        )

        let repository = PokemonRepository(client: client)

        let first = try await repository.damageRelations(for: pokemonA)
        let second = try await repository.damageRelations(for: pokemonB)

        XCTAssertEqual(first.count, 1)
        XCTAssertEqual(second.count, 1)
        XCTAssertEqual(first.first?.double_damage_from.map(\.name), ["ground"])
        XCTAssertEqual(client.fetchTypeCallCount, 1)
    }
}

private final class MockPokeAPIClient: @unchecked Sendable, PokeAPIClient {
    var indexResponse = PokeAPIIndexResponse(results: [])
    var pokemonByName: [String: Pokemon] = [:]
    var pokemonByID: [Int: Pokemon] = [:]
    var speciesResponses: [String: PokemonSpeciesResponse] = [:]
    var evolutionChainResponses: [String: EvolutionChainResponse] = [:]
    var typeResponses: [String: TypeResponse] = [:]

    private(set) var fetchPokemonIndexCallCount = 0
    private(set) var fetchSpeciesCallCount = 0
    private(set) var fetchTypeCallCount = 0

    func fetchPokemonIndex(limit: Int) async throws -> PokeAPIIndexResponse {
        fetchPokemonIndexCallCount += 1
        return indexResponse
    }

    func fetchPokemon(name: String) async throws -> Pokemon {
        if let pokemon = pokemonByName[name] {
            return pokemon
        }

        throw URLError(.badServerResponse)
    }

    func fetchPokemon(id: Int) async throws -> Pokemon {
        if let pokemon = pokemonByID[id] {
            return pokemon
        }

        throw URLError(.badServerResponse)
    }

    func fetchSpecies(url: URL) async throws -> PokemonSpeciesResponse {
        fetchSpeciesCallCount += 1

        if let response = speciesResponses[url.absoluteString] {
            return response
        }

        throw URLError(.badServerResponse)
    }

    func fetchEvolutionChain(url: URL) async throws -> EvolutionChainResponse {
        if let response = evolutionChainResponses[url.absoluteString] {
            return response
        }

        throw URLError(.badServerResponse)
    }

    func fetchType(url: URL) async throws -> TypeResponse {
        fetchTypeCallCount += 1

        if let response = typeResponses[url.absoluteString] {
            return response
        }

        throw URLError(.badServerResponse)
    }
}

private func makePokemon(
    id: Int,
    name: String,
    types: [PokemonTypeEntry] = [
        PokemonTypeEntry(
            slot: 1,
            type: PokemonType(name: "fire", url: "https://pokeapi.co/api/v2/type/10/")
        )
    ],
    stats: [PokemonStatEntry] = [
        PokemonStatEntry(base_stat: 78, stat: PokemonStat(name: "hp"))
    ]
) -> Pokemon {
    Pokemon(
        id: id,
        name: name,
        types: types,
        sprites: PokemonSprites(
            front_default: "https://example.com/\(id).png",
            front_shiny: "https://example.com/\(id)-shiny.png",
            other: OtherSprites(
                officialArtwork: OfficialArtwork(
                    front_default: "https://example.com/\(id)-art.png",
                    front_shiny: "https://example.com/\(id)-art-shiny.png"
                )
            )
        ),
        stats: stats,
        species: PokemonSpeciesReference(
            name: name,
            url: "https://pokeapi.co/api/v2/pokemon-species/\(id)/"
        )
    )
}

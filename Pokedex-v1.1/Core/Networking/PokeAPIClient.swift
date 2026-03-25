import Foundation

protocol PokeAPIClient: Sendable {
    func fetchPokemonIndex(limit: Int) async throws -> PokeAPIIndexResponse
    func fetchPokemon(name: String) async throws -> Pokemon
    func fetchPokemon(id: Int) async throws -> Pokemon
    func fetchSpecies(url: URL) async throws -> PokemonSpeciesResponse
    func fetchEvolutionChain(url: URL) async throws -> EvolutionChainResponse
    func fetchType(url: URL) async throws -> TypeResponse
}

struct PokeAPIIndexResponse: Decodable {
    let results: [PokeAPIIndexItem]
}

struct PokeAPIIndexItem: Decodable {
    let name: String
    let url: String
}

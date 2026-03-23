import Foundation

struct NativePokeAPIClient: PokeAPIClient {
    nonisolated init() {}

    func fetchPokemonIndex(limit: Int) async throws -> PokeAPIIndexResponse {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=\(limit)") else {
            throw URLError(.badURL)
        }

        return try await decode(PokeAPIIndexResponse.self, from: url)
    }

    func fetchPokemon(name: String) async throws -> Pokemon {
        let query = name
            .lowercased()
            .trimmingCharacters(in: .whitespacesAndNewlines)

        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(query)") else {
            throw URLError(.badURL)
        }

        return try await decode(Pokemon.self, from: url)
    }

    func fetchPokemon(id: Int) async throws -> Pokemon {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(id)") else {
            throw URLError(.badURL)
        }

        return try await decode(Pokemon.self, from: url)
    }

    func fetchSpecies(url: URL) async throws -> PokemonSpeciesResponse {
        try await decode(PokemonSpeciesResponse.self, from: url)
    }

    func fetchEvolutionChain(url: URL) async throws -> EvolutionChainResponse {
        try await decode(EvolutionChainResponse.self, from: url)
    }

    func fetchType(url: URL) async throws -> TypeResponse {
        try await decode(TypeResponse.self, from: url)
    }

    private func decode<T: Decodable>(_ type: T.Type, from url: URL) async throws -> T {
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(T.self, from: data)
    }
}

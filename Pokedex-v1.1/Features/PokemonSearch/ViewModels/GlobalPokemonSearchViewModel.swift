import Foundation
import Combine

@MainActor
final class GlobalPokemonSearchViewModel: ObservableObject {

    @Published var results: [Pokemon] = []
    @Published var isLoading = false

    func search(text: String) async {
        let query = text
            .lowercased()
            .trimmingCharacters(in: .whitespacesAndNewlines)

        guard !query.isEmpty else {
            results = []
            return
        }

        isLoading = true
        results.removeAll()

        // Si es número → búsqueda directa
        if let id = Int(query) {
            await fetchPokemon(id: id)
        } else {
            // Nombre
            await fetchPokemon(name: query)
        }

        isLoading = false
    }

    private func fetchPokemon(id: Int) async {
        do {
            let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(id)")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
            results = [pokemon]
        } catch {
            results = []
        }
    }

    private func fetchPokemon(name: String) async {
        do {
            let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(name)")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
            results = [pokemon]
        } catch {
            results = []
        }
    }
}

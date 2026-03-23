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
            let pokemon = try await PokemonRepository.shared.pokemon(id: id)
            results = [pokemon]
        } catch {
            results = []
        }
    }

    private func fetchPokemon(name: String) async {
        do {
            let pokemon = try await PokemonRepository.shared.pokemon(name: name)
            results = [pokemon]
        } catch {
            results = []
        }
    }
}

import Foundation
import Observation
import SwiftUI

@MainActor
@Observable final class RegionPokemonViewModel {

    var pokemons: [Pokemon] = []
    var isLoading = false
    var searchText = ""

    var filteredPokemons: [Pokemon] {
        let trimmed = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmed.count < 2 { return pokemons }

        if let id = Int(trimmed) {
            return pokemons.filter { $0.id == id }
        }

        return pokemons.filter {
            $0.name.localizedCaseInsensitiveContains(trimmed)
        }
    }

    func load(region: Region) async {
        isLoading = true
        pokemons.removeAll()

        do {
            pokemons = try await PokemonRepository.shared.regionPokemons(region: region)
        } catch {
            print("❌ Error cargando región \(region.name): \(error)")
            pokemons = []
        }
        isLoading = false
    }
}

import Foundation
import Combine
import SwiftUI

@MainActor
final class RegionPokemonViewModel: ObservableObject {

    @Published var pokemons: [Pokemon] = []
    @Published var isLoading = false

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

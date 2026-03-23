import SwiftUI
import Foundation
import Combine

@MainActor
final class PokemonDetailViewModel: ObservableObject {

    @Published var pokemon: Pokemon?
    @Published var weaknesses: [String] = []
    @Published var resistances: [String] = []
    @Published var isLoading = false
    @Published var supplementalData: PokemonSupplementalData?

    func loadDetails(for basePokemon: Pokemon) async {
        isLoading = true
        weaknesses.removeAll()
        resistances.removeAll()
        supplementalData = nil

        do {
            let resolvedPokemon = try await resolvedPokemon(from: basePokemon)
            pokemon = resolvedPokemon

            async let relations = PokemonRepository.shared.damageRelations(for: resolvedPokemon)
            async let supplemental = PokemonRepository.shared.supplementalData(for: resolvedPokemon)

            let damageRelations = try await relations
            let loadedSupplemental = try await supplemental

            supplementalData = loadedSupplemental
            process(relations: damageRelations)

            Task(priority: .utility) {
                await PokemonRepository.shared.prefetchAdjacentDetails(around: resolvedPokemon.id)
            }
        } catch {
            print("❌ Error loading pokemon detail:", error)
            pokemon = basePokemon
        }

        isLoading = false
    }

    private func resolvedPokemon(from basePokemon: Pokemon) async throws -> Pokemon {
        if Self.shouldLoadFullPokemon(basePokemon) {
            return try await PokemonRepository.shared.pokemon(id: basePokemon.id)
        }

        return basePokemon
    }

    private static func shouldLoadFullPokemon(_ pokemon: Pokemon) -> Bool {
        if pokemon.types.isEmpty || pokemon.stats.isEmpty {
            return true
        }

        let artwork = pokemon.sprites.other?.officialArtwork?.front_default
        return artwork == nil && pokemon.sprites.front_default == nil
    }

    private func process(relations: [DamageRelations]) {
        var weak = Set<String>()
        var resist = Set<String>()

        for r in relations {
            r.double_damage_from.forEach {
                weak.insert($0.name.capitalized)
            }
            r.half_damage_from.forEach {
                resist.insert($0.name.capitalized)
            }
            r.no_damage_from.forEach {
                resist.insert($0.name.capitalized)
            }
        }

        weaknesses = Array(weak).sorted()
        resistances = Array(resist).sorted()
    }
}

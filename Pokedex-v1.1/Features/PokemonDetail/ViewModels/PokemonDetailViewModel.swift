import SwiftUI
import Foundation
import Combine

@MainActor
final class PokemonDetailViewModel: ObservableObject {

    @Published var weaknesses: [String] = []
    @Published var resistances: [String] = []
    @Published var isLoading = false
    private static var typeRelationsCache: [String: DamageRelations] = [:]

    func loadDamageRelations(for pokemon: Pokemon) async {
        isLoading = true
        weaknesses.removeAll()
        resistances.removeAll()

        do {
            let relations = try await fetchDamageRelations(for: pokemon.types)
            process(relations: relations)
        } catch {
            print("❌ Error damage relations:", error)
        }

        isLoading = false
    }

    private func fetchDamageRelations(for types: [PokemonTypeEntry]) async throws -> [DamageRelations] {
        var results: [DamageRelations] = []

        for entry in types {
            if let cached = Self.typeRelationsCache[entry.type.url] {
                results.append(cached)
                continue
            }

            guard let url = URL(string: entry.type.url) else { continue }
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoded = try JSONDecoder().decode(TypeResponse.self, from: data)
            Self.typeRelationsCache[entry.type.url] = decoded.damage_relations
            results.append(decoded.damage_relations)
        }

        return results
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

// MARK: - Models PokéAPI

struct TypeResponse: Decodable {
    let damage_relations: DamageRelations
}

struct DamageRelations: Decodable {
    let double_damage_from: [NamedAPIResource]
    let half_damage_from: [NamedAPIResource]
    let no_damage_from: [NamedAPIResource]
}

struct NamedAPIResource: Decodable {
    let name: String
    let url: String
}

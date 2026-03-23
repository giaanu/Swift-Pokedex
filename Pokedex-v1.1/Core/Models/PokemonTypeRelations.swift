import Foundation

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

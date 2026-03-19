import Foundation

struct Pokemon: Decodable {
    let id: Int
    let name: String
    let types: [PokemonTypeEntry]
    let sprites: PokemonSprites
    let stats: [PokemonStatEntry]
}

struct PokemonTypeEntry: Decodable {
    let slot: Int
    let type: PokemonType
}

struct PokemonType: Decodable {
    let name: String
    let url: String
}

struct PokemonSprites: Codable {
    let front_default: String?
    let other: OtherSprites?
}

struct OtherSprites: Codable {
    let officialArtwork: OfficialArtwork?

    enum CodingKeys: String, CodingKey {
        case officialArtwork = "official-artwork"
    }
}

struct OfficialArtwork: Codable {
    let front_default: String?

    enum CodingKeys: String, CodingKey {
        case front_default = "front_default"
    }
}

struct PokemonStatEntry: Decodable {
    let base_stat: Int
    let stat: PokemonStat
}

struct PokemonStat: Decodable {
    let name: String
}

import Foundation

struct Pokemon: Decodable {
    let id: Int
    let name: String
    let types: [PokemonTypeEntry]
    let sprites: PokemonSprites
    let stats: [PokemonStatEntry]
    let species: PokemonSpeciesReference?
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
    let front_shiny: String?
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
    let front_shiny: String?

    enum CodingKeys: String, CodingKey {
        case front_default = "front_default"
        case front_shiny = "front_shiny"
    }
}

struct PokemonStatEntry: Decodable {
    let base_stat: Int
    let stat: PokemonStat
}

struct PokemonStat: Decodable {
    let name: String
}

struct PokemonSpeciesReference: Codable {
    let name: String
    let url: String
}

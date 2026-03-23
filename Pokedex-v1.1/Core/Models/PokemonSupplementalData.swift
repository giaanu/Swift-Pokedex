import Foundation

struct PokemonSupplementalData {
    let description: String?
    let evolutionChain: [Pokemon]
    let shinyArtworkURL: String?
    let specialForms: [PokemonSpecialForm]
}

struct PokemonSpecialForm: Identifiable {
    let title: String
    let pokemon: Pokemon

    var id: Int { pokemon.id }
}

struct PokemonSpeciesResponse: Decodable {
    let flavor_text_entries: [FlavorTextEntry]
    let evolution_chain: APIResourceURL
    let varieties: [PokemonVariety]
}

struct FlavorTextEntry: Decodable {
    let flavor_text: String
    let language: NamedAPIResource
    let version: NamedAPIResource
}

struct APIResourceURL: Decodable {
    let url: String
}

struct PokemonVariety: Decodable {
    let is_default: Bool
    let pokemon: NamedAPIResource
}

struct EvolutionChainResponse: Decodable {
    let chain: EvolutionChainLink
}

struct EvolutionChainLink: Decodable {
    let species: NamedAPIResource
    let evolves_to: [EvolutionChainLink]
}

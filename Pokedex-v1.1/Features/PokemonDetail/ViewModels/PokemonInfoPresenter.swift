import SwiftUI
import Foundation

struct PokemonInfoPresenter {
    let pokemon: Pokemon
    let supplementalData: PokemonSupplementalData?

    var primaryTypeColor: Color {
        guard let primaryType = pokemon.types.sorted(by: { $0.slot < $1.slot }).first?.type.name else {
            return Color(red: 0.78, green: 0.28, blue: 0.23)
        }
        return PokemonTypeColor.color(for: primaryType)
    }

    var formsCountLabel: String {
        let count = supplementalData?.specialForms.count ?? 0
        return count == 0 ? "Base" : "\(count + 1)"
    }

    var evolutionsCountLabel: String {
        let count = supplementalData?.evolutionChain.count ?? 1
        return "\(count)"
    }

    func artworkURL(for p: Pokemon) -> URL? {
        if let urlString = p.sprites.other?.officialArtwork?.front_default,
           let url = URL(string: urlString) {
            return url
        }

        if let urlString = p.sprites.front_default,
           let url = URL(string: urlString) {
            return url
        }

        return nil
    }

    var currentArtworkURL: URL? {
        artworkURL(for: pokemon)
    }
}

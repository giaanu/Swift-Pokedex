import SwiftUI
import Combine
import Foundation

struct PokemonGridCard: View {

    let pokemon: Pokemon

    var body: some View {
        VStack(spacing: 8) {

            AsyncImage(url: pokemonImageURL) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(height: 72)
            } placeholder: {
                ProgressView()
                    .frame(height: 72)
            }

            Text(pokemon.name.capitalized)
                .font(DSTypography.cardTitle)
                .foregroundColor(DSColors.textPrimary)
                .lineLimit(1)
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(DSColors.glassMedium.opacity(1.0))
        )
    }

    private var pokemonImageURL: URL? {
        if let url = pokemon.sprites.other?.officialArtwork?.front_default {
            return URL(string: url)
        }
        if let url = pokemon.sprites.front_default {
            return URL(string: url)
        }
        return nil
    }
}

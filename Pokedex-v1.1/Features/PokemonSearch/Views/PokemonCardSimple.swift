import SwiftUI

struct PokemonCardSimple: View {

    let pokemon: Pokemon

    var body: some View {
        VStack(spacing: 8) {

            if let urlString =
                pokemon.sprites.other?.officialArtwork?.front_default
                ?? pokemon.sprites.front_default,
               let url = URL(string: urlString) {

                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(height: 80)
                } placeholder: {
                    ProgressView()
                }
            }

            Text(pokemon.name.capitalized)
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(.black)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .background(.ultraThinMaterial)
        .cornerRadius(16)
    }
}

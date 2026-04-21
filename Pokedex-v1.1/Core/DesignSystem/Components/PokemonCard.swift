import SwiftUI

struct PokemonCard: View {

    let pokemon: Pokemon

    var body: some View {
        VStack(spacing: 10) {

            Text(String(format: "#%04d", pokemon.id))
                .font(.system(.caption, design: .rounded).weight(.semibold))
                .foregroundColor(.secondary)

            AsyncImage(url: imageURL) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .frame(height: 90)

            Text(pokemon.name.capitalized)
                .font(.system(.headline, design: .rounded).weight(.bold))
                .foregroundColor(.black)
                .lineLimit(1)
                .minimumScaleFactor(0.85)
        }
        .padding(16)
        .frame(height: 180)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: DSSpacing.cornerMedium)
                .fill(Color.white.opacity(0.18))
                .overlay(
                    RoundedRectangle(cornerRadius: DSSpacing.cornerMedium)
                        .stroke(Color.white.opacity(0.22), lineWidth: 1)
                )
        )
    }

    private var imageURL: URL? {
        if let url = pokemon.sprites.other?.officialArtwork?.front_default {
            return URL(string: url)
        }
        return nil
    }
}

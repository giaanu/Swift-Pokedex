import SwiftUI

struct PokemonCard: View {

    let pokemon: Pokemon

    var body: some View {
        VStack(spacing: 10) {

            // ===== NÚMERO =====
            Text("#\(pokemon.id)")
                .font(.caption)
                .foregroundColor(.secondary)

            // ===== IMAGEN =====
            AsyncImage(url: imageURL) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .frame(height: 90)

            // ===== NOMBRE =====
            Text(pokemon.name.capitalized)
                .font(.headline)
                .foregroundColor(.black)
                .lineLimit(1)
                .minimumScaleFactor(0.85)
        }
        .padding(16)
        .frame(height: 180)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 18)
                .fill(Color.white.opacity(0.18))
                .overlay(
                    RoundedRectangle(cornerRadius: 18)
                        .stroke(Color.white.opacity(0.18), lineWidth: 1)
                )
        )
    }

    // MARK: - Helpers

    private var imageURL: URL? {
        if let url = pokemon.sprites.other?.officialArtwork?.front_default {
            return URL(string: url)
        }
        return nil
    }
}

import SwiftUI

struct PokemonInfoView: View {
    let pokemon: Pokemon

    var body: some View {
        ZStack {

            // 📟 Marco Pokédex
            Image("pokedex_screen_main")
                .resizable()
                .scaledToFit()
                .ignoresSafeArea()

            VStack {

                // 🟨 PANTALLA BLANCA (zona fija)
                VStack(spacing: 12) {
                    if let urlString =
                        pokemon.sprites.other?.officialArtwork?.front_default
                        ?? pokemon.sprites.front_default,
                       let url = URL(string: urlString) {
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .scaledToFit()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(height: 160)
                    } else {
                        Image(systemName: "photo")
                            .font(.system(size: 42, weight: .medium))
                            .foregroundColor(.gray)
                            .frame(height: 160)
                    }

                    Text("#\(pokemon.id)")
                        .foregroundColor(.black)

                    Text(pokemon.name.capitalized)
                        .font(.title.bold())
                        .foregroundColor(.black)
                }
                .frame(height: 400)
                .frame(maxWidth: .infinity)
                .padding(.top, 155)

                Spacer()

                // 🟩 PANTALLA VERDE (zona fija)
                VStack {
                    HStack(spacing: 8) {
                        ForEach(pokemon.types, id: \.slot) { entry in
                            TypeChip(type: entry.type.name)
                        }
                    }
                }
                .frame(height: 130)
                .frame(maxWidth: .infinity)
                .padding(.bottom, 135)
            }
        }
    }
}

import SwiftUI

struct PokemonInfoView: View {
    let pokemon: Pokemon
    let supplementalData: PokemonSupplementalData?
    let isLoadingSupplemental: Bool

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 16) {
                headerCard

                if let description = supplementalData?.description, !description.isEmpty {
                    PokedexSection(title: "Descripcion Pokedex") {
                        Text(description)
                            .font(.callout)
                            .foregroundColor(.black)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }

                if let evolutionChain = supplementalData?.evolutionChain, !evolutionChain.isEmpty {
                    PokedexSection(title: "Cadena Evolutiva") {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(evolutionChain, id: \.id) { evolutionPokemon in
                                    PokemonVariantCard(
                                        title: evolutionPokemon.name.capitalized,
                                        imageURL: artworkURL(for: evolutionPokemon)
                                    )
                                }
                            }
                            .padding(.vertical, 4)
                        }
                    }
                }

                if let shinyURL = supplementalData?.shinyArtworkURL,
                   let url = URL(string: shinyURL) {
                    PokedexSection(title: "Version Shiny") {
                        PokemonVariantCard(
                            title: "\(pokemon.name.capitalized) Shiny",
                            imageURL: url,
                            imageHeight: 120
                        )
                    }
                }

                if let specialForms = supplementalData?.specialForms, !specialForms.isEmpty {
                    PokedexSection(title: "Mega / Gigantamax") {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(specialForms) { form in
                                    PokemonVariantCard(
                                        title: form.title,
                                        imageURL: artworkURL(for: form.pokemon)
                                    )
                                }
                            }
                            .padding(.vertical, 4)
                        }
                    }
                }

                if isLoadingSupplemental {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .tint(.black)
                        .padding(.top, 8)
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 28)
            .padding(.bottom, 36)
        }
    }

    private var headerCard: some View {
        PokedexSection(title: "Ficha") {
            VStack(spacing: 14) {
                if let url = artworkURL(for: pokemon) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(height: 180)
                } else {
                    Image(systemName: "photo")
                        .font(.system(size: 42, weight: .medium))
                        .foregroundColor(.gray)
                        .frame(height: 180)
                }

                Text("#\(pokemon.id)")
                    .font(.headline)
                    .foregroundColor(.black)

                Text(pokemon.name.capitalized)
                    .font(.title.bold())
                    .foregroundColor(.black)

                HStack(spacing: 8) {
                    ForEach(pokemon.types, id: \.slot) { entry in
                        TypeChip(type: entry.type.name)
                    }
                }
            }
            .frame(maxWidth: .infinity)
        }
    }

    private func artworkURL(for pokemon: Pokemon) -> URL? {
        if let urlString = pokemon.sprites.other?.officialArtwork?.front_default,
           let url = URL(string: urlString) {
            return url
        }

        if let urlString = pokemon.sprites.front_default,
           let url = URL(string: urlString) {
            return url
        }

        return nil
    }
}

private struct PokemonVariantCard: View {
    let title: String
    let imageURL: URL?
    var imageHeight: CGFloat = 84

    var body: some View {
        VStack(spacing: 10) {
            if let imageURL {
                AsyncImage(url: imageURL) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: imageHeight)
            } else {
                Image(systemName: "photo")
                    .font(.system(size: 26, weight: .medium))
                    .foregroundColor(.gray)
                    .frame(height: imageHeight)
            }

            Text(title)
                .font(.subheadline.weight(.semibold))
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .frame(maxWidth: .infinity)
        }
        .padding(12)
        .frame(width: 132)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(Color.white.opacity(0.45))
        )
    }
}

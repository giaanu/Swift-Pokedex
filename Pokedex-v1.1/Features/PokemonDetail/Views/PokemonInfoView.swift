import SwiftUI

struct PokemonInfoView: View {
    let pokemon: Pokemon
    let supplementalData: PokemonSupplementalData?
    let isLoadingSupplemental: Bool

    private var presenter: PokemonInfoPresenter {
        PokemonInfoPresenter(pokemon: pokemon, supplementalData: supplementalData)
    }

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 18) {
                PokemonHeaderCardView(presenter: presenter)

                if let description = supplementalData?.description, !description.isEmpty {
                    PokedexSection(title: "Descripción Pokédex") {
                        Text(description)
                            .font(.callout)
                            .foregroundColor(.black)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }

                if let evolutionChain = supplementalData?.evolutionChain, !evolutionChain.isEmpty {
                    PokedexSection(title: "Cadena Evolutiva") {
                        LazyVGrid(
                            columns: [
                                GridItem(.flexible(), spacing: 10),
                                GridItem(.flexible(), spacing: 10),
                                GridItem(.flexible(), spacing: 10)
                            ],
                            spacing: 10
                        ) {
                            ForEach(evolutionChain, id: \.id) { evolutionPokemon in
                                NavigationLink {
                                    PokemonDetailView(
                                        pokemon: evolutionPokemon,
                                        onNextPokemon: {},
                                        onPreviousPokemon: {}
                                    )
                                } label: {
                                    PokemonVariantCard(
                                        title: evolutionPokemon.name.capitalized,
                                        imageURL: presenter.artworkURL(for: evolutionPokemon),
                                        imageHeight: 68,
                                        compact: true
                                    )
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }
                }

                if let shinyURL = supplementalData?.shinyArtworkURL,
                   let url = URL(string: shinyURL) {
                    PokedexSection(title: "Versión Shiny") {
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
                                        imageURL: presenter.artworkURL(for: form.pokemon)
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
            .padding(.top, 6)
            .padding(.bottom, 36)
        }
    }
}

struct PokemonVariantCard: View {
    let title: String
    let imageURL: URL?
    var imageHeight: CGFloat = 84
    var compact: Bool = false

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
                .font(compact ? .footnote.weight(.semibold) : .subheadline.weight(.semibold))
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .frame(maxWidth: .infinity)
        }
        .padding(compact ? 10 : 12)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 18)
                .fill(Color.white.opacity(0.54))
                .overlay(
                    RoundedRectangle(cornerRadius: 18)
                        .stroke(Color.white.opacity(0.58), lineWidth: 1)
                )
        )
    }
}

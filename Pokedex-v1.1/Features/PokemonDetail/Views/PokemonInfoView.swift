import SwiftUI

struct PokemonInfoView: View {
    let pokemon: Pokemon
    let supplementalData: PokemonSupplementalData?
    let isLoadingSupplemental: Bool

    private var primaryTypeColor: Color {
        guard let primaryType = pokemon.types.sorted(by: { $0.slot < $1.slot }).first?.type.name else {
            return Color(red: 0.78, green: 0.28, blue: 0.23)
        }

        return PokemonTypeColor.color(for: primaryType)
    }

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 18) {
                headerCard

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
                                        imageURL: artworkURL(for: evolutionPokemon),
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
            .padding(.top, 6)
            .padding(.bottom, 36)
        }
    }

    private var headerCard: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 30)
                .fill(
                    LinearGradient(
                        colors: [
                            Color.white.opacity(0.94),
                            primaryTypeColor.opacity(0.22),
                            Color.white.opacity(0.90)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(Color.white.opacity(0.70), lineWidth: 1.2)
                )
                .shadow(color: Color.black.opacity(0.14), radius: 18, x: 0, y: 12)

            Circle()
                .fill(primaryTypeColor.opacity(0.20))
                .frame(width: 220, height: 220)
                .blur(radius: 4)
                .offset(x: 120, y: 18)

            VStack(alignment: .leading, spacing: 16) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Ficha de Campo")
                            .font(.caption.bold())
                            .foregroundColor(.black.opacity(0.55))
                            .textCase(.uppercase)
                            .tracking(1.3)

                        Text(pokemon.name.capitalized)
                            .font(.system(size: 34, weight: .black, design: .rounded))
                            .foregroundColor(.black.opacity(0.86))

                        Text(String(format: "#%04d", pokemon.id))
                            .font(.headline.weight(.semibold))
                            .foregroundColor(.black.opacity(0.58))
                    }

                    Spacer()

                    VStack(alignment: .trailing, spacing: 6) {
                        Text("Estado")
                            .font(.caption.weight(.semibold))
                            .foregroundColor(.black.opacity(0.45))
                            .textCase(.uppercase)

                        Text("Registrado")
                            .font(.subheadline.bold())
                            .foregroundColor(primaryTypeColor.opacity(0.95))
                    }
                }

                ZStack {
                    Circle()
                        .stroke(Color.white.opacity(0.40), lineWidth: 16)
                        .frame(width: 220, height: 220)

                    Circle()
                        .stroke(primaryTypeColor.opacity(0.16), lineWidth: 1)
                        .frame(width: 254, height: 254)

                    if let url = artworkURL(for: pokemon) {
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .scaledToFit()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(height: 210)
                        .shadow(color: Color.black.opacity(0.14), radius: 16, x: 0, y: 10)
                    } else {
                        Image(systemName: "photo")
                            .font(.system(size: 42, weight: .medium))
                            .foregroundColor(.gray)
                            .frame(height: 210)
                    }
                }
                .frame(maxWidth: .infinity)

                VStack(alignment: .leading, spacing: 12) {
                    HStack(spacing: 8) {
                        ForEach(pokemon.types, id: \.slot) { entry in
                            TypeChip(type: entry.type.name)
                        }
                    }

                    HStack(spacing: 10) {
                        DetailBadge(title: "Formas", value: formsCountLabel)
                        DetailBadge(title: "Evoluciones", value: evolutionsCountLabel)
                        if supplementalData?.shinyArtworkURL != nil {
                            DetailBadge(title: "Shiny", value: "Sí")
                        }
                    }
                }
            }
            .padding(22)
        }
        .frame(maxWidth: .infinity)
    }

    private var formsCountLabel: String {
        let count = supplementalData?.specialForms.count ?? 0
        return count == 0 ? "Base" : "\(count + 1)"
    }

    private var evolutionsCountLabel: String {
        let count = supplementalData?.evolutionChain.count ?? 1
        return "\(count)"
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

private struct DetailBadge: View {
    let title: String
    let value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.caption.weight(.semibold))
                .foregroundColor(.black.opacity(0.46))
                .textCase(.uppercase)

            Text(value)
                .font(.subheadline.bold())
                .foregroundColor(.black.opacity(0.82))
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(Color.white.opacity(0.60))
        )
    }
}

private struct PokemonVariantCard: View {
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

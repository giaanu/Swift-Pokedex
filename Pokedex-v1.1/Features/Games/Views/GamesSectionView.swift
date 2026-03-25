import SwiftUI

struct GamesSectionView: View {
    let onMenuTap: () -> Void

    @State private var selectedGenerationID = GameCatalog.all.first?.id ?? ""

    private var selectedGeneration: GameGenerationData? {
        GameCatalog.all.first(where: { $0.id == selectedGenerationID }) ?? GameCatalog.all.first
    }

    private let starterColumns = [
        GridItem(.flexible(), spacing: 14),
        GridItem(.flexible(), spacing: 14),
        GridItem(.flexible(), spacing: 14)
    ]

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                header
                generationTabs

                if let generation = selectedGeneration {
                    generationSummary(generation)
                    startersSection(generation)
                }
            }
            .padding(.bottom, 120)
        }
        .scrollIndicators(.hidden)
        .onAppear {
            if selectedGenerationID.isEmpty {
                selectedGenerationID = GameCatalog.all.first?.id ?? ""
            }
        }
    }

    private var header: some View {
        HStack(alignment: .top) {
            Button(action: onMenuTap) {
                Image(systemName: "line.3.horizontal")
                    .font(DSTypography.menuIcon)
                    .foregroundColor(.white)
                    .frame(width: 44, height: 44)
                    .background(Circle().fill(DSColors.accentStrong))
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 4) {
                Text("JUEGOS")
                    .font(DSTypography.screenTitle)
                    .foregroundColor(DSColors.textPrimary)

                Text("Generaciones e iniciales")
                    .font(DSTypography.screenSubtitle)
                    .foregroundColor(DSColors.accent)
            }
        }
        .padding(.top, DSSpacing.sectionTop)
        .padding(.horizontal, DSSpacing.xLarge)
    }

    private var generationTabs: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(GameCatalog.all) { generation in
                    Button {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            selectedGenerationID = generation.id
                        }
                    } label: {
                        Text(generation.generationTitle)
                            .font(.subheadline.bold())
                            .foregroundColor(selectedGenerationID == generation.id ? .white : DSColors.textPrimary)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 16)
                            .background(
                                Capsule()
                                    .fill(selectedGenerationID == generation.id ? DSColors.accentStrong : DSColors.glassSoft)
                            )
                            .overlay(
                                Capsule()
                                    .stroke(
                                        selectedGenerationID == generation.id ? DSColors.accentStrong : DSColors.glassBorderSoft,
                                        lineWidth: 1
                                    )
                            )
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, DSSpacing.xLarge)
        }
    }

    private func generationSummary(_ generation: GameGenerationData) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading, spacing: 6) {
                Text("\(generation.generationTitle) · \(generation.regionName)")
                    .font(DSTypography.sectionTitle)
                    .foregroundColor(DSColors.textPrimary)

                Text(generation.yearsLabel)
                    .font(.subheadline.weight(.semibold))
                    .foregroundColor(DSColors.accent)
            }

            VStack(alignment: .leading, spacing: 10) {
                Text("Juegos principales")
                    .font(.subheadline.bold())
                    .foregroundColor(DSColors.textPrimary)

                FlexibleChipGrid(items: generation.games)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(18)
        .background(
            RoundedRectangle(cornerRadius: 18)
                .fill(DSColors.glassMedium)
                .overlay(
                    RoundedRectangle(cornerRadius: 18)
                        .stroke(DSColors.glassBorderSoft, lineWidth: 1)
                )
        )
        .padding(.horizontal, DSSpacing.xLarge)
    }

    private func startersSection(_ generation: GameGenerationData) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Iniciales")
                .font(DSTypography.sectionTitle)
                .foregroundColor(DSColors.textPrimary)
                .padding(.horizontal, DSSpacing.xLarge)

            LazyVGrid(columns: starterColumns, spacing: 14) {
                ForEach(generation.starters) { starter in
                    NavigationLink {
                        PokemonDetailView(
                            pokemon: starter.placeholderPokemon,
                            onNextPokemon: {},
                            onPreviousPokemon: {}
                        )
                    } label: {
                        PokemonGridCard(pokemon: starter.placeholderPokemon)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, DSSpacing.xLarge)
        }
    }
}

private struct FlexibleChipGrid: View {
    let items: [String]

    var body: some View {
        WrapView(items: items, spacing: 10) { item in
            Text(item)
                .font(.footnote.weight(.semibold))
                .foregroundColor(DSColors.textPrimary)
                .padding(.vertical, 8)
                .padding(.horizontal, 12)
                .background(
                    Capsule()
                        .fill(DSColors.glassStrong)
                )
        }
    }
}

private extension StarterPokemonData {
    var placeholderPokemon: Pokemon {
        Pokemon(
            id: id,
            name: name,
            types: [],
            sprites: PokemonSprites(
                front_default: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png",
                front_shiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/\(id).png",
                other: OtherSprites(
                    officialArtwork: OfficialArtwork(
                        front_default: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(id).png",
                        front_shiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/shiny/\(id).png"
                    )
                )
            ),
            stats: [],
            species: PokemonSpeciesReference(
                name: name,
                url: "https://pokeapi.co/api/v2/pokemon-species/\(id)/"
            )
        )
    }
}

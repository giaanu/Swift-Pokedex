import SwiftUI

struct GymsSectionView: View {
    let onMenuTap: () -> Void

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                header

                VStack(spacing: 14) {
                    ForEach(GymCatalog.all) { region in
                        GymRegionCard(region: region)
                    }
                }
                .padding(.horizontal, DSSpacing.xLarge)
                .padding(.bottom, 120)
            }
        }
        .scrollIndicators(.hidden)
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
                Text("GIMNASIOS")
                    .font(DSTypography.screenTitle)
                    .foregroundColor(DSColors.textPrimary)

                Text("Regiones, lideres y equipos")
                    .font(DSTypography.screenSubtitle)
                    .foregroundColor(DSColors.accent)
            }
        }
        .padding(.top, DSSpacing.sectionTop)
        .padding(.horizontal, DSSpacing.xLarge)
    }
}

private struct GymRegionCard: View {
    let region: GymRegionData

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(region.regionName.uppercased())
                .font(DSTypography.sectionTitle)
                .foregroundColor(DSColors.accent)

            ForEach(region.gyms) { gym in
                NavigationLink {
                    GymDetailView(gym: gym)
                } label: {
                    Text(gym.displayTitle)
                        .font(.subheadline.bold())
                        .foregroundColor(DSColors.textPrimary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 10)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(DSColors.glassSoft)
                        )
                }
                .buttonStyle(.plain)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(DSColors.glassMedium)
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(DSColors.glassBorderSoft, lineWidth: 1)
                )
        )
    }
}

private struct GymDetailView: View {
    @Environment(\.dismiss) private var dismiss
    let gym: GymData

    private let columns = [
        GridItem(.flexible(), spacing: 14),
        GridItem(.flexible(), spacing: 14),
        GridItem(.flexible(), spacing: 14)
    ]

    private var pokemons: [Pokemon] {
        GymTeamBuilder.fullTeam(for: gym).map { gymPokemon in
            Pokemon(
                id: gymPokemon.id,
                name: gymPokemon.name,
                types: [],
                sprites: PokemonSprites(
                    front_default: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(gymPokemon.id).png",
                    front_shiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/\(gymPokemon.id).png",
                    other: OtherSprites(
                        officialArtwork: OfficialArtwork(
                            front_default: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(gymPokemon.id).png",
                            front_shiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/shiny/\(gymPokemon.id).png"
                        )
                    )
                ),
                stats: [],
                species: PokemonSpeciesReference(
                    name: gymPokemon.name,
                    url: "https://pokeapi.co/api/v2/pokemon-species/\(gymPokemon.id)/"
                )
            )
        }
    }

    var body: some View {
        PokedexBackground {
            VStack(spacing: 0) {
                Spacer().frame(height: 142)

                VStack(alignment: .leading, spacing: 8) {
                    Text(gym.displayTitle)
                        .font(DSTypography.gymTitle)
                        .foregroundColor(DSColors.textPrimary)

                    Text("Entrenador: \(gym.leader)")
                        .font(DSTypography.trainerTitle)
                        .foregroundColor(DSColors.accent)

                    Text("Tipo: \(gym.specialty) · Insignia: \(gym.badge)")
                        .font(DSTypography.bodyStrong)
                        .foregroundColor(DSColors.accent.opacity(0.95))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 16)
                .padding(.vertical, 14)
                .background(
                    RoundedRectangle(cornerRadius: 14)
                        .fill(DSColors.glassStrong)
                        .overlay(
                            RoundedRectangle(cornerRadius: 14)
                                .stroke(DSColors.glassBorderStrong, lineWidth: 1)
                        )
                )
                .padding(.horizontal, 16)
                .padding(.bottom, 12)

                Text("Equipo Pokemon")
                    .font(DSTypography.sectionTitle)
                    .foregroundColor(DSColors.textPrimary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 8)

                ScrollView {
                    LazyVGrid(columns: columns, spacing: 14) {
                        ForEach(pokemons, id: \.id) { pokemon in
                            NavigationLink {
                                PokemonDetailView(
                                    pokemon: pokemon,
                                    onNextPokemon: {},
                                    onPreviousPokemon: {}
                                )
                            } label: {
                                PokemonGridCard(pokemon: pokemon)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 40)
                }
                .scrollIndicators(.hidden)
            }
        }
        .navigationBarBackButtonHidden(true)
        .modifier(EdgeSwipeBack(dismiss: dismiss.callAsFunction))
    }
}

private extension GymData {
    var displayTitle: String {
        "Gimnasio de \(city)"
    }
}

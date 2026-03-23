import SwiftUI

struct PokemonDetailView: View {

    @Environment(\.dismiss) private var dismiss

    let pokemon: Pokemon
    let onNextPokemon: () -> Void
    let onPreviousPokemon: () -> Void

    @State private var selectedTab = 0
    @StateObject private var viewModel = PokemonDetailViewModel()
    @StateObject private var pokemonLoader = PokemonViewModel()

    private var displayPokemon: Pokemon {
        pokemonLoader.pokemon ?? pokemon
    }

    var body: some View {

        PokedexBackground {
            VStack {

                // ===== CONTENIDO =====
                TabView(selection: $selectedTab) {

                    // INFO
                    PokemonInfoView(
                        pokemon: displayPokemon,
                        supplementalData: viewModel.supplementalData,
                        isLoadingSupplemental: viewModel.isLoadingSupplemental
                    )
                        .tag(0)

                    // STATS
                    PokemonStatsView(
                        pokemon: displayPokemon,
                        weaknesses: viewModel.weaknesses,
                        resistances: viewModel.resistances
                    )
                    .tag(1)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .animation(.easeInOut, value: selectedTab)

                // ===== INDICADOR =====
                HStack(spacing: 8) {
                    Circle()
                        .fill(selectedTab == 0 ? .blue : .gray.opacity(0.4))
                        .frame(width: 8, height: 8)

                    Circle()
                        .fill(selectedTab == 1 ? .blue : .gray.opacity(0.4))
                        .frame(width: 8, height: 8)
                }
                .padding(.bottom, 20)
            }
        }
        // 🔥 Carga debilidades/resistencias cada vez que cambia el Pokémon
        .task(id: pokemon.id) {
            var currentPokemon = pokemon

            if shouldLoadFullPokemon {
                await pokemonLoader.fetchPokemon(name: String(pokemon.id))
                currentPokemon = pokemonLoader.pokemon ?? pokemon
            }

            await viewModel.loadDamageRelations(for: currentPokemon)
            await viewModel.loadSupplementalData(for: currentPokemon)
        }
        .navigationBarBackButtonHidden(true)
        .modifier(EdgeSwipeBack(dismiss: dismiss.callAsFunction))
        // Gestos
        .gesture(
            DragGesture(minimumDistance: 20)
                .onEnded { value in
                    let h = value.translation.width
                    let v = value.translation.height

                    if abs(h) > abs(v) {
                        // 👉 HORIZONTAL: cambia de Pokémon
                        if h < -50 {
                            onNextPokemon()
                        } else if h > 50 {
                            onPreviousPokemon()
                        }
                    } else {
                        // 👉 VERTICAL: cambia de tab
                        if v < -50 {
                            withAnimation { selectedTab = 1 }
                        } else if v > 50 {
                            withAnimation { selectedTab = 0 }
                        }
                    }
                }
        )
    }

    private var shouldLoadFullPokemon: Bool {
        if pokemon.types.isEmpty || pokemon.stats.isEmpty {
            return true
        }

        let artwork = pokemon.sprites.other?.officialArtwork?.front_default
        return artwork == nil && pokemon.sprites.front_default == nil
    }
}

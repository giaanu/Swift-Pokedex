import SwiftUI

struct PokemonDetailView: View {

    @Environment(\.dismiss) private var dismiss

    let pokemon: Pokemon
    let onNextPokemon: () -> Void
    let onPreviousPokemon: () -> Void

    @State private var selectedTab = 0
    @StateObject private var viewModel = PokemonDetailViewModel()

    private var displayPokemon: Pokemon {
        viewModel.pokemon ?? pokemon
    }

    var body: some View {

        PokedexBackground {
            VStack(spacing: 18) {
                detailHeader

                // ===== CONTENIDO =====
                TabView(selection: $selectedTab) {

                    // INFO
                    PokemonInfoView(
                        pokemon: displayPokemon,
                        supplementalData: viewModel.supplementalData,
                        isLoadingSupplemental: viewModel.isLoading
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
                        .fill(selectedTab == 0 ? DSColors.accentStrong : .white.opacity(0.35))
                        .frame(width: 8, height: 8)

                    Circle()
                        .fill(selectedTab == 1 ? DSColors.accentStrong : .white.opacity(0.35))
                        .frame(width: 8, height: 8)
                }
                .padding(.bottom, 18)
            }
        }
        // 🔥 Carga debilidades/resistencias cada vez que cambia el Pokémon
        .task(id: pokemon.id) {
            await viewModel.loadDetails(for: pokemon)
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

    private var detailHeader: some View {
        HStack {
            Spacer()

            Text(selectedTab == 0 ? "Información" : "Estadísticas")
                .font(.caption.bold())
                .foregroundColor(.white.opacity(0.88))
                .padding(.horizontal, 14)
                .padding(.vertical, 8)
                .background(
                    Capsule()
                        .fill(Color.white.opacity(0.18))
                        .overlay(
                            Capsule()
                                .stroke(Color.white.opacity(0.18), lineWidth: 1)
                        )
                )
        }
        .padding(.horizontal, 22)
        .padding(.top, 20)
    }
}

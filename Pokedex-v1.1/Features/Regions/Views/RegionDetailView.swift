import SwiftUI
import Foundation
import Combine

struct RegionDetailView: View {

    @Environment(\.dismiss) private var dismiss

    let region: Region
    @StateObject private var viewModel = RegionPokemonViewModel()
    @State private var searchText = ""

    // 👉 3 columnas
    private let columns = [
        GridItem(.flexible(), spacing: 14),
        GridItem(.flexible(), spacing: 14),
        GridItem(.flexible(), spacing: 14)
    ]

    private var filteredPokemons: [Pokemon] {
        let trimmed = searchText.trimmingCharacters(in: .whitespacesAndNewlines)

        // si querés guard de 2 caracteres también acá:
        if trimmed.count < 2 { return viewModel.pokemons }

        if let id = Int(trimmed) {
            return viewModel.pokemons.filter { $0.id == id }
        }

        return viewModel.pokemons.filter {
            $0.name.localizedCaseInsensitiveContains(trimmed)
        }
    }

    var body: some View {

        ZStack {

            PokedexBackground {

                VStack(spacing: 0) {

                    Spacer().frame(height: 110)

                    // Título a la derecha
                    HStack {
                        Spacer()
                        Text(region.name)
                            .font(.title.bold())
                            .foregroundColor(.black)
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 10)

                    // 🔍 Buscador región
                    TextField("Buscar en \(region.name)...", text: $searchText)
                        .padding(12)
                        .foregroundStyle(.black)
                        .tint(.blue)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled(true)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.white.opacity(0.9))
                        )
                        .padding(.horizontal, 16)
                        .padding(.bottom, 10)

                    if viewModel.isLoading {
                        ProgressView("Cargando Pokémon...")
                            .padding(.top, 20)
                    }

                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 14) {
                            ForEach(filteredPokemons, id: \.id) { pokemon in
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
        }
        .navigationBarBackButtonHidden(true)
        .modifier(EdgeSwipeBack(dismiss: dismiss.callAsFunction))
        .task {
            await viewModel.load(region: region)
        }
    }
}

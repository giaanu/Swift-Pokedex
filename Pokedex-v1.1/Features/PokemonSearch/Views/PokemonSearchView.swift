import SwiftUI
import Foundation

struct PokemonSearchView: View {
    @StateObject var viewModel = PokemonViewModel()
    @State private var searchText = ""
    
    var body: some View {
        VStack(spacing: 20) {

            // 🔍 Campo de búsqueda
            TextField("Buscar Pokémon...", text: $searchText)
                .textFieldStyle(.roundedBorder)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled(true)
                .padding(.horizontal)

            // 🔎 Botón de buscar
            Button("Buscar") {
                Task {
                    let trimmed = searchText.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
                    guard !trimmed.isEmpty else { return }
                    await viewModel.fetchPokemon(name: trimmed)
                }
            }
            .buttonStyle(.borderedProminent)

            // ⏳ Cargando
            if viewModel.isLoading {
                ProgressView("Cargando...")
                    .padding()
            }

            // ✅ Resultado Pokémon
            if let pokemon = viewModel.pokemon {
                VStack(spacing: 10) {

                    if let url = pokemon.sprites.other?.officialArtwork?.front_default ?? pokemon.sprites.front_default,
                       let imageURL = URL(string: url) {

                        AsyncImage(url: imageURL) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image.resizable().scaledToFit().frame(width: 150, height: 150)
                            case .failure:
                                Image(systemName: "photo")
                            @unknown default:
                                EmptyView()
                            }
                        }
                    }
                }
                Text("#\(pokemon.id)")
                    .font(.headline)

                Text(pokemon.name.capitalized)
                    .font(.largeTitle)
                    .bold()

                VStack {
                    Text("Tipos:")
                        .bold()

                    ForEach(pokemon.types, id: \.slot) { entry in
                        Text(PokemonDisplayText.localizedType(entry.type.name))
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color.blue.opacity(0.2))
                            .cornerRadius(8)
                    }
                }
                .padding()
            }

            // ❌ Error mensaje
            if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .padding()
            }

            Spacer()
        }
        .navigationTitle("Pokedex")
    }
}

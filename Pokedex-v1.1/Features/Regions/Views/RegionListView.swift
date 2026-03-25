import SwiftUI
import Foundation

enum HomeSection {
    case pokedex
    case gyms
    case games
}

struct RegionListView: View {

    @State private var searchText: String = ""
    @FocusState private var isSearchFieldFocused: Bool
    @State private var pokemonIndex: [SearchResult] = []
    @State private var isLoadingIndex = false
    @State private var hasLoadedIndex = false

    @State private var isMenuOpen = false
    @State private var selectedSection: HomeSection = .pokedex

    private var filteredPokemons: [SearchResult] {
        let trimmed = searchText.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !trimmed.isEmpty else { return [] }

        if let id = Int(trimmed) {
            return pokemonIndex.filter { $0.id == id }.prefix(20).map { $0 }
        }

        return pokemonIndex
            .filter { $0.name.localizedCaseInsensitiveContains(trimmed) }
            .prefix(20)
            .map { $0 }
    }

    var body: some View {
        ZStack(alignment: .leading) {
            mainContent
                .disabled(isMenuOpen)

            if isMenuOpen {
                DSColors.menuScrim
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation {
                            isMenuOpen = false
                        }
                    }

                sideMenu
                    .transition(.move(edge: .leading))
                    .zIndex(2)
            }
        }
        .animation(.easeInOut(duration: 0.2), value: isMenuOpen)
        .task {
            await loadPokemonIndexIfNeeded()
        }
    }

    private var mainContent: some View {
        PokedexBackground {
            switch selectedSection {
            case .pokedex:
                pokedexContent
            case .gyms:
                GymsSectionView {
                    withAnimation {
                        isMenuOpen = true
                    }
                }
            case .games:
                GamesSectionView {
                    withAnimation {
                        isMenuOpen = true
                    }
                }
            }
        }
    }

    private var pokedexContent: some View {
        ScrollView {
            VStack(spacing: 16) {
                pokedexHeader

                TextField("Buscar Pokemon...", text: $searchText)
                    .padding(DSSpacing.medium)
                    .foregroundStyle(DSColors.textPrimary)
                    .tint(DSColors.accent)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(true)
                    .focused($isSearchFieldFocused)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(DSColors.searchFieldBackground)
                    )
                    .padding(.horizontal, DSSpacing.xLarge)

                if !filteredPokemons.isEmpty {
                    VStack(spacing: 12) {
                        ForEach(filteredPokemons, id: \.id) { pokemon in
                            NavigationLink {
                                PokemonDetailView(
                                    pokemon: pokemon.placeholderPokemon,
                                    onNextPokemon: {},
                                    onPreviousPokemon: {}
                                )
                            } label: {
                                Text("\(pokemon.region) --> \(pokemon.name.capitalized)")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .foregroundColor(DSColors.textPrimary)
                                    .padding()
                                    .background(
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(DSColors.resultRowBackground)
                                    )
                            }
                            .buttonStyle(.plain)
                            .simultaneousGesture(
                                TapGesture().onEnded {
                                    isSearchFieldFocused = false
                                }
                            )
                        }
                    }
                    .padding(.horizontal, DSSpacing.xLarge)
                }

                if isLoadingIndex && pokemonIndex.isEmpty {
                    ProgressView("Cargando indice de Pokemon...")
                        .padding(.top, 8)
                }

                VStack(spacing: 16) {
                    ForEach(Region.all) { region in
                        NavigationLink {
                            RegionDetailView(region: region)
                        } label: {
                            RegionCard(region: region)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, DSSpacing.xLarge)
                .padding(.bottom, 120)
            }
        }
        .scrollIndicators(.hidden)
    }

    private var pokedexHeader: some View {
        HStack(alignment: .top) {
            menuButton

            Spacer()

            VStack(alignment: .trailing, spacing: 4) {
                Text("POKEDEX")
                    .font(DSTypography.screenTitle)
                    .foregroundColor(DSColors.textPrimary)

                Text("Selecciona una region")
                    .font(DSTypography.screenSubtitle)
                    .foregroundColor(DSColors.accent)
            }
        }
        .padding(.top, DSSpacing.sectionTop)
        .padding(.horizontal, DSSpacing.xLarge)
    }

    private var menuButton: some View {
        Button {
            withAnimation {
                isMenuOpen = true
            }
        } label: {
            Image(systemName: "line.3.horizontal")
                .font(DSTypography.menuIcon)
                .foregroundColor(.white)
                .frame(width: 44, height: 44)
                .background(Circle().fill(DSColors.accentStrong))
        }
    }

    private var sideMenu: some View {
        VStack(alignment: .leading, spacing: 18) {
            Text("MENU")
                .font(DSTypography.menuTitle)
                .foregroundColor(DSColors.textPrimary)

            menuItem(title: "Pokedex", isSelected: selectedSection == .pokedex) {
                selectedSection = .pokedex
            }

            menuItem(title: "Gimnasios", isSelected: selectedSection == .gyms) {
                selectedSection = .gyms
            }

            menuItem(title: "Juegos", isSelected: selectedSection == .games) {
                selectedSection = .games
            }

            Spacer()
        }
        .padding(.top, DSSpacing.sectionTop)
        .padding(.horizontal, DSSpacing.xLarge)
        .frame(width: 250)
        .frame(maxHeight: .infinity)
        .background(DSColors.sideMenuBackground)
    }

    private func menuItem(title: String, isSelected: Bool, action: @escaping () -> Void) -> some View {
        Button {
            withAnimation {
                action()
                isMenuOpen = false
            }
        } label: {
            HStack {
                Text(title)
                    .font(DSTypography.menuItem)
                    .foregroundColor(isSelected ? DSColors.accent : DSColors.textPrimary)

                Spacer()

                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(DSColors.accent)
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(isSelected ? DSColors.accent.opacity(0.12) : Color.gray.opacity(0.08))
            )
        }
        .buttonStyle(.plain)
    }

    private func loadPokemonIndexIfNeeded() async {
        guard !hasLoadedIndex else { return }

        hasLoadedIndex = true
        isLoadingIndex = true
        defer { isLoadingIndex = false }

        do {
            let index = try await PokemonRepository.shared.pokemonIndex()
            pokemonIndex = index.map { item in
                SearchResult(id: item.id, name: item.name, region: regionName(for: item.id))
            }
            .sorted { $0.id < $1.id }
        } catch {
            print("Error cargando indice Pokemon: \(error)")
        }
    }

    private func regionName(for id: Int) -> String {
        Region.all.first(where: { $0.pokedexRange.contains(id) })?.name ?? "Desconocida"
    }
}

private struct SearchResult: Identifiable {
    let id: Int
    let name: String
    let region: String

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

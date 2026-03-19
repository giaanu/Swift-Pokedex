//
//  PokemonViewModel.swift
//  Pokedex-v1
//
//  Created by Gianluca Zarrelli on 09/12/2025.
//
import Combine
import Foundation

@MainActor
class PokemonViewModel: ObservableObject {
    
    @Published var pokemon: Pokemon?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    func fetchPokemon(name: String) async {
        isLoading = true
        errorMessage = nil
        
        // Normalizar el texto que ingresa el usuario
        let safeName = name
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()
        
        guard !safeName.isEmpty else {
            errorMessage = "Ingresá un nombre válido"
            isLoading = false
            return
        }
        
        do {
            pokemon = try await PokemonRepository.shared.pokemon(name: safeName)
        } catch {
            print("ERROR →", error)
            errorMessage = "No se pudo cargar el Pokémon"
        }
        
        isLoading = false
    }
}

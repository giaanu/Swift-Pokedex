//
//  Pokedex_v1_1App.swift
//  Pokedex-v1.1
//
//  Created by Gianluca Zarrelli on 13/12/2025.
//

import SwiftUI

@main
struct Pokedex_v1_1App: App {
    init() {
        URLCache.shared = URLCache(memoryCapacity: 64 * 1024 * 1024, diskCapacity: 512 * 1024 * 1024)
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

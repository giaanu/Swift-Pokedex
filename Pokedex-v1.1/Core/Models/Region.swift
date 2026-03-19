import Foundation

struct Region: Identifiable {
    let id = UUID()
    let name: String
    let pokedexRange: ClosedRange<Int>

    static let all: [Region] = [
        Region(name: "Kanto", pokedexRange: 1...151),
        Region(name: "Johto", pokedexRange: 152...251),
        Region(name: "Hoenn", pokedexRange: 252...386),
        Region(name: "Sinnoh", pokedexRange: 387...494),
        Region(name: "Teselia", pokedexRange: 495...649),
        Region(name: "Kalos", pokedexRange: 650...721),
        Region(name: "Alola", pokedexRange: 722...809),
        Region(name: "Galar", pokedexRange: 810...898),
        Region(name: "Hisui", pokedexRange: 899...905),
        Region(name: "Paldea", pokedexRange: 906...1025)
    ]
}

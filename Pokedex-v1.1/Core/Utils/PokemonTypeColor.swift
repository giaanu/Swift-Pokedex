import SwiftUI

struct PokemonTypeColor {
    static func color(for type: String) -> Color {
        switch type.lowercased() {
        case "normal": return .gray
        case "fire": return .red
        case "water": return .blue
        case "electric": return .yellow
        case "grass": return .green
        case "ice": return .cyan
        case "fighting": return .orange
        case "poison": return .purple
        case "ground": return .brown
        case "flying": return .indigo
        case "psychic": return .pink
        case "bug": return .mint
        case "rock": return .gray.opacity(0.7)
        case "ghost": return .indigo.opacity(0.7)
        case "dragon": return .teal
        case "dark": return .black
        case "steel": return .gray.opacity(0.5)
        case "fairy": return .pink.opacity(0.7)
        default: return .gray
        }
    }
}

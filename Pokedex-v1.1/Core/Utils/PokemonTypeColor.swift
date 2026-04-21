import SwiftUI

struct PokemonTypeColor {
    static func color(for type: String) -> Color {
        switch type.lowercased() {
        case "normal":   return Color(red: 0.66, green: 0.65, blue: 0.59)
        case "fire":     return Color(red: 1.00, green: 0.42, blue: 0.21)
        case "water":    return Color(red: 0.24, green: 0.66, blue: 0.95)
        case "electric": return Color(red: 0.98, green: 0.83, blue: 0.17)
        case "grass":    return Color(red: 0.40, green: 0.73, blue: 0.41)
        case "ice":      return Color(red: 0.37, green: 0.82, blue: 0.90)
        case "fighting": return Color(red: 0.76, green: 0.19, blue: 0.18)
        case "poison":   return Color(red: 0.64, green: 0.25, blue: 0.72)
        case "ground":   return Color(red: 0.88, green: 0.69, blue: 0.31)
        case "flying":   return Color(red: 0.55, green: 0.52, blue: 0.90)
        case "psychic":  return Color(red: 0.98, green: 0.22, blue: 0.51)
        case "bug":      return Color(red: 0.65, green: 0.74, blue: 0.10)
        case "rock":     return Color(red: 0.72, green: 0.63, blue: 0.38)
        case "ghost":    return Color(red: 0.45, green: 0.34, blue: 0.59)
        case "dragon":   return Color(red: 0.44, green: 0.22, blue: 0.87)
        case "dark":     return Color(red: 0.44, green: 0.34, blue: 0.27)
        case "steel":    return Color(red: 0.72, green: 0.72, blue: 0.82)
        case "fairy":    return Color(red: 0.99, green: 0.57, blue: 0.74)
        default:         return Color(red: 0.66, green: 0.65, blue: 0.59)
        }
    }
}

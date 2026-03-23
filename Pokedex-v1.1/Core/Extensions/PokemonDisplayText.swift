import Foundation

enum PokemonDisplayText {
    static func localizedType(_ raw: String) -> String {
        switch raw.lowercased() {
        case "normal": return "Normal"
        case "fire": return "Fuego"
        case "water": return "Agua"
        case "electric": return "Eléctrico"
        case "grass": return "Planta"
        case "ice": return "Hielo"
        case "fighting": return "Lucha"
        case "poison": return "Veneno"
        case "ground": return "Tierra"
        case "flying": return "Volador"
        case "psychic": return "Psíquico"
        case "bug": return "Bicho"
        case "rock": return "Roca"
        case "ghost": return "Fantasma"
        case "dragon": return "Dragón"
        case "dark": return "Siniestro"
        case "steel": return "Acero"
        case "fairy": return "Hada"
        default: return raw.capitalized
        }
    }

    static func localizedStat(_ raw: String) -> String {
        switch raw.lowercased() {
        case "hp": return "PS"
        case "attack": return "Ataque"
        case "defense": return "Defensa"
        case "special-attack": return "Ataque Especial"
        case "special-defense": return "Defensa Especial"
        case "speed": return "Velocidad"
        default: return raw.capitalized
        }
    }
}

import Foundation

enum GymTeamBuilder {
    static func fullTeam(for gym: GymData) -> [GymPokemonData] {
        var team = gym.pokemons
        let pool = poolForSpecialty(gym.specialty)

        for candidate in pool where team.count < 6 {
            if !team.contains(where: { $0.id == candidate.id }) {
                team.append(candidate)
            }
        }

        return team
    }

    private static func poolForSpecialty(_ specialty: String) -> [GymPokemonData] {
        let key = specialty.lowercased()

        if key.contains("electrico") {
            return electricPool
        }
        if key.contains("agua") {
            return waterPool
        }
        if key.contains("fuego") {
            return firePool
        }
        if key.contains("planta") {
            return grassPool
        }
        if key.contains("roca") {
            return rockPool
        }
        if key.contains("veneno") {
            return poisonPool
        }
        if key.contains("psiquico") {
            return psychicPool
        }
        if key.contains("tierra") {
            return groundPool
        }
        if key.contains("volador") {
            return flyingPool
        }
        if key.contains("bicho") {
            return bugPool
        }
        if key.contains("lucha") {
            return fightingPool
        }
        if key.contains("hielo") {
            return icePool
        }
        if key.contains("acero") {
            return steelPool
        }
        if key.contains("dragon") {
            return dragonPool
        }
        if key.contains("fantasma") {
            return ghostPool
        }
        if key.contains("normal") {
            return normalPool
        }
        if key.contains("hada") {
            return fairyPool
        }
        if key.contains("siniestro") {
            return darkPool
        }

        return fallbackPool
    }

    private static let rockPool: [GymPokemonData] = [
        .init(id: 74, name: "Geodude"),
        .init(id: 95, name: "Onix"),
        .init(id: 111, name: "Rhyhorn"),
        .init(id: 139, name: "Omastar"),
        .init(id: 141, name: "Kabutops"),
        .init(id: 248, name: "Tyranitar")
    ]

    private static let waterPool: [GymPokemonData] = [
        .init(id: 120, name: "Staryu"),
        .init(id: 121, name: "Starmie"),
        .init(id: 134, name: "Vaporeon"),
        .init(id: 130, name: "Gyarados"),
        .init(id: 226, name: "Mantine"),
        .init(id: 350, name: "Milotic")
    ]

    private static let electricPool: [GymPokemonData] = [
        .init(id: 25, name: "Pikachu"),
        .init(id: 26, name: "Raichu"),
        .init(id: 82, name: "Magneton"),
        .init(id: 310, name: "Manectric"),
        .init(id: 587, name: "Emolga"),
        .init(id: 405, name: "Luxray")
    ]

    private static let grassPool: [GymPokemonData] = [
        .init(id: 44, name: "Gloom"),
        .init(id: 71, name: "Victreebel"),
        .init(id: 103, name: "Exeggutor"),
        .init(id: 407, name: "Roserade"),
        .init(id: 709, name: "Trevenant"),
        .init(id: 930, name: "Arboliva")
    ]

    private static let poisonPool: [GymPokemonData] = [
        .init(id: 109, name: "Koffing"),
        .init(id: 110, name: "Weezing"),
        .init(id: 89, name: "Muk"),
        .init(id: 24, name: "Arbok"),
        .init(id: 169, name: "Crobat"),
        .init(id: 454, name: "Toxicroak")
    ]

    private static let psychicPool: [GymPokemonData] = [
        .init(id: 64, name: "Kadabra"),
        .init(id: 65, name: "Alakazam"),
        .init(id: 122, name: "Mr. Mime"),
        .init(id: 326, name: "Grumpig"),
        .init(id: 561, name: "Sigilyph"),
        .init(id: 956, name: "Espathra")
    ]

    private static let firePool: [GymPokemonData] = [
        .init(id: 58, name: "Growlithe"),
        .init(id: 59, name: "Arcanine"),
        .init(id: 78, name: "Rapidash"),
        .init(id: 324, name: "Torkoal"),
        .init(id: 851, name: "Centiskorch"),
        .init(id: 146, name: "Moltres")
    ]

    private static let groundPool: [GymPokemonData] = [
        .init(id: 111, name: "Rhyhorn"),
        .init(id: 112, name: "Rhydon"),
        .init(id: 27, name: "Sandshrew"),
        .init(id: 31, name: "Nidoqueen"),
        .init(id: 34, name: "Nidoking"),
        .init(id: 530, name: "Excadrill")
    ]

    private static let flyingPool: [GymPokemonData] = [
        .init(id: 16, name: "Pidgey"),
        .init(id: 17, name: "Pidgeotto"),
        .init(id: 18, name: "Pidgeot"),
        .init(id: 334, name: "Altaria"),
        .init(id: 373, name: "Salamence"),
        .init(id: 249, name: "Lugia")
    ]

    private static let bugPool: [GymPokemonData] = [
        .init(id: 14, name: "Kakuna"),
        .init(id: 15, name: "Beedrill"),
        .init(id: 123, name: "Scyther"),
        .init(id: 542, name: "Leavanny"),
        .init(id: 666, name: "Vivillon"),
        .init(id: 918, name: "Spidops")
    ]

    private static let ghostPool: [GymPokemonData] = [
        .init(id: 92, name: "Gastly"),
        .init(id: 93, name: "Haunter"),
        .init(id: 94, name: "Gengar"),
        .init(id: 429, name: "Mismagius"),
        .init(id: 593, name: "Jellicent"),
        .init(id: 972, name: "Houndstone")
    ]

    private static let fightingPool: [GymPokemonData] = [
        .init(id: 66, name: "Machop"),
        .init(id: 67, name: "Machoke"),
        .init(id: 68, name: "Machamp"),
        .init(id: 448, name: "Lucario"),
        .init(id: 853, name: "Grapploct"),
        .init(id: 534, name: "Conkeldurr")
    ]

    private static let icePool: [GymPokemonData] = [
        .init(id: 87, name: "Dewgong"),
        .init(id: 221, name: "Piloswine"),
        .init(id: 460, name: "Abomasnow"),
        .init(id: 614, name: "Beartic"),
        .init(id: 713, name: "Avalugg"),
        .init(id: 975, name: "Cetitan")
    ]

    private static let steelPool: [GymPokemonData] = [
        .init(id: 81, name: "Magnemite"),
        .init(id: 82, name: "Magneton"),
        .init(id: 208, name: "Steelix"),
        .init(id: 303, name: "Mawile"),
        .init(id: 306, name: "Aggron"),
        .init(id: 884, name: "Duraludon")
    ]

    private static let dragonPool: [GymPokemonData] = [
        .init(id: 148, name: "Dragonair"),
        .init(id: 149, name: "Dragonite"),
        .init(id: 230, name: "Kingdra"),
        .init(id: 334, name: "Altaria"),
        .init(id: 612, name: "Haxorus"),
        .init(id: 384, name: "Rayquaza")
    ]

    private static let normalPool: [GymPokemonData] = [
        .init(id: 241, name: "Miltank"),
        .init(id: 289, name: "Slaking"),
        .init(id: 531, name: "Audino"),
        .init(id: 982, name: "Dudunsparce"),
        .init(id: 975, name: "Cetitan"),
        .init(id: 143, name: "Snorlax")
    ]

    private static let fairyPool: [GymPokemonData] = [
        .init(id: 36, name: "Clefable"),
        .init(id: 282, name: "Gardevoir"),
        .init(id: 303, name: "Mawile"),
        .init(id: 671, name: "Florges"),
        .init(id: 778, name: "Mimikyu"),
        .init(id: 869, name: "Alcremie")
    ]

    private static let darkPool: [GymPokemonData] = [
        .init(id: 197, name: "Umbreon"),
        .init(id: 248, name: "Tyranitar"),
        .init(id: 510, name: "Liepard"),
        .init(id: 571, name: "Zoroark"),
        .init(id: 861, name: "Grimmsnarl"),
        .init(id: 359, name: "Absol")
    ]

    private static let fallbackPool: [GymPokemonData] = [
        .init(id: 25, name: "Pikachu"),
        .init(id: 94, name: "Gengar"),
        .init(id: 149, name: "Dragonite"),
        .init(id: 448, name: "Lucario"),
        .init(id: 700, name: "Sylveon"),
        .init(id: 6, name: "Charizard")
    ]
}

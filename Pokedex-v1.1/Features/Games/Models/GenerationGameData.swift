import Foundation

struct GameGenerationData: Identifiable {
    let id: String
    let generationTitle: String
    let regionName: String
    let yearsLabel: String
    let games: [String]
    let starters: [StarterPokemonData]
}

struct StarterPokemonData: Identifiable {
    let id: Int
    let name: String
}

enum GameCatalog {
    static let all: [GameGenerationData] = [
        GameGenerationData(
            id: "gen-1",
            generationTitle: "Gen 1",
            regionName: "Kanto",
            yearsLabel: "1996-1999",
            games: ["Rojo", "Azul", "Amarillo"],
            starters: [
                StarterPokemonData(id: 1, name: "Bulbasaur"),
                StarterPokemonData(id: 4, name: "Charmander"),
                StarterPokemonData(id: 7, name: "Squirtle")
            ]
        ),
        GameGenerationData(
            id: "gen-2",
            generationTitle: "Gen 2",
            regionName: "Johto",
            yearsLabel: "1999-2001",
            games: ["Oro", "Plata", "Cristal"],
            starters: [
                StarterPokemonData(id: 152, name: "Chikorita"),
                StarterPokemonData(id: 155, name: "Cyndaquil"),
                StarterPokemonData(id: 158, name: "Totodile")
            ]
        ),
        GameGenerationData(
            id: "gen-3",
            generationTitle: "Gen 3",
            regionName: "Hoenn",
            yearsLabel: "2002-2004",
            games: ["Rubi", "Zafiro", "Esmeralda", "Rojo Fuego", "Verde Hoja"],
            starters: [
                StarterPokemonData(id: 252, name: "Treecko"),
                StarterPokemonData(id: 255, name: "Torchic"),
                StarterPokemonData(id: 258, name: "Mudkip")
            ]
        ),
        GameGenerationData(
            id: "gen-4",
            generationTitle: "Gen 4",
            regionName: "Sinnoh",
            yearsLabel: "2006-2010",
            games: ["Diamante", "Perla", "Platino", "HeartGold", "SoulSilver"],
            starters: [
                StarterPokemonData(id: 387, name: "Turtwig"),
                StarterPokemonData(id: 390, name: "Chimchar"),
                StarterPokemonData(id: 393, name: "Piplup")
            ]
        ),
        GameGenerationData(
            id: "gen-5",
            generationTitle: "Gen 5",
            regionName: "Teselia",
            yearsLabel: "2010-2012",
            games: ["Negro", "Blanco", "Negro 2", "Blanco 2"],
            starters: [
                StarterPokemonData(id: 495, name: "Snivy"),
                StarterPokemonData(id: 498, name: "Tepig"),
                StarterPokemonData(id: 501, name: "Oshawott")
            ]
        ),
        GameGenerationData(
            id: "gen-6",
            generationTitle: "Gen 6",
            regionName: "Kalos",
            yearsLabel: "2013-2014",
            games: ["X", "Y", "Rubi Omega", "Zafiro Alfa"],
            starters: [
                StarterPokemonData(id: 650, name: "Chespin"),
                StarterPokemonData(id: 653, name: "Fennekin"),
                StarterPokemonData(id: 656, name: "Froakie")
            ]
        ),
        GameGenerationData(
            id: "gen-7",
            generationTitle: "Gen 7",
            regionName: "Alola",
            yearsLabel: "2016-2018",
            games: ["Sol", "Luna", "Ultrasol", "Ultraluna", "Let's Go Pikachu", "Let's Go Eevee"],
            starters: [
                StarterPokemonData(id: 722, name: "Rowlet"),
                StarterPokemonData(id: 725, name: "Litten"),
                StarterPokemonData(id: 728, name: "Popplio")
            ]
        ),
        GameGenerationData(
            id: "gen-8",
            generationTitle: "Gen 8",
            regionName: "Galar",
            yearsLabel: "2019-2022",
            games: ["Espada", "Escudo", "Diamante Brillante", "Perla Reluciente", "Legends Arceus"],
            starters: [
                StarterPokemonData(id: 810, name: "Grookey"),
                StarterPokemonData(id: 813, name: "Scorbunny"),
                StarterPokemonData(id: 816, name: "Sobble")
            ]
        ),
        GameGenerationData(
            id: "gen-9",
            generationTitle: "Gen 9",
            regionName: "Paldea",
            yearsLabel: "2022-actualidad",
            games: ["Escarlata", "Purpura"],
            starters: [
                StarterPokemonData(id: 906, name: "Sprigatito"),
                StarterPokemonData(id: 909, name: "Fuecoco"),
                StarterPokemonData(id: 912, name: "Quaxly")
            ]
        )
    ]
}

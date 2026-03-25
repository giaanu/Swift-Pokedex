import Foundation

struct GymRegionData: Identifiable {
    let id: String
    let regionName: String
    let referenceGame: String
    let gyms: [GymData]
}

struct GymData: Identifiable {
    let id: String
    let name: String
    let city: String
    let leader: String
    let specialty: String
    let badge: String
    let pokemons: [GymPokemonData]
}

struct GymPokemonData: Identifiable {
    let id: Int
    let name: String
}

enum GymCatalog {
    static let all: [GymRegionData] = [
        GymRegionData(
            id: "kanto",
            regionName: "Kanto",
            referenceGame: "FireRed/LeafGreen",
            gyms: [
                GymData(id: "kanto-1", name: "Gimnasio de Ciudad Plateada", city: "Ciudad Plateada", leader: "Brock", specialty: "Roca", badge: "Roca", pokemons: [
                    GymPokemonData(id: 74, name: "Geodude"),
                    GymPokemonData(id: 95, name: "Onix")
                ]),
                GymData(id: "kanto-2", name: "Gimnasio Celeste", city: "Ciudad Celeste", leader: "Misty", specialty: "Agua", badge: "Cascada", pokemons: [
                    GymPokemonData(id: 120, name: "Staryu"),
                    GymPokemonData(id: 121, name: "Starmie")
                ]),
                GymData(id: "kanto-3", name: "Gimnasio Carmin", city: "Ciudad Carmin", leader: "Lt. Surge", specialty: "Electrico", badge: "Trueno", pokemons: [
                    GymPokemonData(id: 100, name: "Voltorb"),
                    GymPokemonData(id: 25, name: "Pikachu"),
                    GymPokemonData(id: 26, name: "Raichu")
                ]),
                GymData(id: "kanto-4", name: "Gimnasio Azulona", city: "Ciudad Azulona", leader: "Erika", specialty: "Planta", badge: "Arcoiris", pokemons: [
                    GymPokemonData(id: 71, name: "Victreebel"),
                    GymPokemonData(id: 114, name: "Tangela"),
                    GymPokemonData(id: 45, name: "Vileplume")
                ]),
                GymData(id: "kanto-5", name: "Gimnasio Fucsia", city: "Ciudad Fucsia", leader: "Koga", specialty: "Veneno", badge: "Alma", pokemons: [
                    GymPokemonData(id: 109, name: "Koffing"),
                    GymPokemonData(id: 109, name: "Koffing"),
                    GymPokemonData(id: 89, name: "Muk"),
                    GymPokemonData(id: 110, name: "Weezing")
                ]),
                GymData(id: "kanto-6", name: "Gimnasio Azafran", city: "Ciudad Azafran", leader: "Sabrina", specialty: "Psiquico", badge: "Pantano", pokemons: [
                    GymPokemonData(id: 64, name: "Kadabra"),
                    GymPokemonData(id: 122, name: "Mr. Mime"),
                    GymPokemonData(id: 49, name: "Venomoth"),
                    GymPokemonData(id: 65, name: "Alakazam")
                ]),
                GymData(id: "kanto-7", name: "Gimnasio Isla Canela", city: "Isla Canela", leader: "Blaine", specialty: "Fuego", badge: "Volcan", pokemons: [
                    GymPokemonData(id: 58, name: "Growlithe"),
                    GymPokemonData(id: 77, name: "Ponyta"),
                    GymPokemonData(id: 78, name: "Rapidash"),
                    GymPokemonData(id: 59, name: "Arcanine")
                ]),
                GymData(id: "kanto-8", name: "Gimnasio Verde", city: "Ciudad Verde", leader: "Giovanni", specialty: "Tierra", badge: "Tierra", pokemons: [
                    GymPokemonData(id: 111, name: "Rhyhorn"),
                    GymPokemonData(id: 51, name: "Dugtrio"),
                    GymPokemonData(id: 31, name: "Nidoqueen"),
                    GymPokemonData(id: 34, name: "Nidoking"),
                    GymPokemonData(id: 112, name: "Rhydon")
                ])
            ]
        ),
        GymRegionData(
            id: "johto",
            regionName: "Johto",
            referenceGame: "HeartGold/SoulSilver",
            gyms: [
                GymData(id: "johto-1", name: "Gimnasio Malva", city: "Ciudad Malva", leader: "Falkner", specialty: "Volador", badge: "Cefiro", pokemons: [
                    GymPokemonData(id: 16, name: "Pidgey"),
                    GymPokemonData(id: 17, name: "Pidgeotto")
                ]),
                GymData(id: "johto-2", name: "Gimnasio Trigal", city: "Ciudad Trigal", leader: "Whitney", specialty: "Normal", badge: "Llanura", pokemons: [
                    GymPokemonData(id: 35, name: "Clefairy"),
                    GymPokemonData(id: 241, name: "Miltank")
                ]),
                GymData(id: "johto-3", name: "Gimnasio Iris", city: "Ciudad Iris", leader: "Bugsy", specialty: "Bicho", badge: "Colmena", pokemons: [
                    GymPokemonData(id: 11, name: "Metapod"),
                    GymPokemonData(id: 14, name: "Kakuna"),
                    GymPokemonData(id: 123, name: "Scyther")
                ]),
                GymData(id: "johto-4", name: "Gimnasio Endrino", city: "Ciudad Endrino", leader: "Morty", specialty: "Fantasma", badge: "Niebla", pokemons: [
                    GymPokemonData(id: 92, name: "Gastly"),
                    GymPokemonData(id: 93, name: "Haunter"),
                    GymPokemonData(id: 93, name: "Haunter"),
                    GymPokemonData(id: 94, name: "Gengar")
                ]),
                GymData(id: "johto-5", name: "Gimnasio Orquidea", city: "Ciudad Orquidea", leader: "Chuck", specialty: "Lucha", badge: "Tormenta", pokemons: [
                    GymPokemonData(id: 57, name: "Primeape"),
                    GymPokemonData(id: 62, name: "Poliwrath")
                ]),
                GymData(id: "johto-6", name: "Gimnasio Caoba", city: "Ciudad Caoba", leader: "Pryce", specialty: "Hielo", badge: "Glaciar", pokemons: [
                    GymPokemonData(id: 86, name: "Seel"),
                    GymPokemonData(id: 87, name: "Dewgong"),
                    GymPokemonData(id: 221, name: "Piloswine")
                ]),
                GymData(id: "johto-7", name: "Gimnasio Olivo", city: "Ciudad Olivo", leader: "Jasmine", specialty: "Acero", badge: "Mineral", pokemons: [
                    GymPokemonData(id: 81, name: "Magnemite"),
                    GymPokemonData(id: 81, name: "Magnemite"),
                    GymPokemonData(id: 208, name: "Steelix")
                ]),
                GymData(id: "johto-8", name: "Gimnasio Ebeno", city: "Ciudad Ebeno", leader: "Clair", specialty: "Dragon", badge: "Levantada", pokemons: [
                    GymPokemonData(id: 148, name: "Dragonair"),
                    GymPokemonData(id: 148, name: "Dragonair"),
                    GymPokemonData(id: 130, name: "Gyarados"),
                    GymPokemonData(id: 230, name: "Kingdra")
                ])
            ]
        ),
        GymRegionData(
            id: "hoenn",
            regionName: "Hoenn",
            referenceGame: "Omega Ruby/Alpha Sapphire",
            gyms: [
                GymData(id: "hoenn-1", name: "Gimnasio Ferrica", city: "Ciudad Ferrica", leader: "Roxanne", specialty: "Roca", badge: "Piedra", pokemons: [
                    GymPokemonData(id: 74, name: "Geodude"),
                    GymPokemonData(id: 299, name: "Nosepass")
                ]),
                GymData(id: "hoenn-2", name: "Gimnasio Azuliza", city: "Pueblo Azuliza", leader: "Brawly", specialty: "Lucha", badge: "Puño", pokemons: [
                    GymPokemonData(id: 66, name: "Machop"),
                    GymPokemonData(id: 296, name: "Makuhita")
                ]),
                GymData(id: "hoenn-3", name: "Gimnasio Malvalona", city: "Ciudad Malvalona", leader: "Wattson", specialty: "Electrico", badge: "Dinamo", pokemons: [
                    GymPokemonData(id: 81, name: "Magnemite"),
                    GymPokemonData(id: 100, name: "Voltorb"),
                    GymPokemonData(id: 82, name: "Magneton")
                ]),
                GymData(id: "hoenn-4", name: "Gimnasio Lavacalda", city: "Pueblo Lavacalda", leader: "Flannery", specialty: "Fuego", badge: "Calor", pokemons: [
                    GymPokemonData(id: 218, name: "Slugma"),
                    GymPokemonData(id: 322, name: "Numel"),
                    GymPokemonData(id: 324, name: "Torkoal")
                ]),
                GymData(id: "hoenn-5", name: "Gimnasio Petalia", city: "Ciudad Petalia", leader: "Norman", specialty: "Normal", badge: "Equilibrio", pokemons: [
                    GymPokemonData(id: 289, name: "Slaking"),
                    GymPokemonData(id: 288, name: "Vigoroth"),
                    GymPokemonData(id: 289, name: "Slaking")
                ]),
                GymData(id: "hoenn-6", name: "Gimnasio Arborada", city: "Ciudad Arborada", leader: "Winona", specialty: "Volador", badge: "Pluma", pokemons: [
                    GymPokemonData(id: 277, name: "Swellow"),
                    GymPokemonData(id: 279, name: "Pelipper"),
                    GymPokemonData(id: 227, name: "Skarmory"),
                    GymPokemonData(id: 334, name: "Altaria")
                ]),
                GymData(id: "hoenn-7", name: "Gimnasio Algaria", city: "Ciudad Algaria", leader: "Tate y Liza", specialty: "Psiquico", badge: "Mente", pokemons: [
                    GymPokemonData(id: 337, name: "Lunatone"),
                    GymPokemonData(id: 338, name: "Solrock")
                ]),
                GymData(id: "hoenn-8", name: "Gimnasio Arrecipolis", city: "Ciudad Arrecipolis", leader: "Wallace", specialty: "Agua", badge: "Lluvia", pokemons: [
                    GymPokemonData(id: 370, name: "Luvdisc"),
                    GymPokemonData(id: 340, name: "Whiscash"),
                    GymPokemonData(id: 364, name: "Sealeo"),
                    GymPokemonData(id: 119, name: "Seaking"),
                    GymPokemonData(id: 350, name: "Milotic")
                ])
            ]
        ),
        GymRegionData(
            id: "sinnoh",
            regionName: "Sinnoh",
            referenceGame: "Brilliant Diamond/Shining Pearl",
            gyms: [
                GymData(id: "sinnoh-1", name: "Gimnasio Pirita", city: "Ciudad Pirita", leader: "Roark", specialty: "Roca", badge: "Carbon", pokemons: [
                    GymPokemonData(id: 74, name: "Geodude"),
                    GymPokemonData(id: 95, name: "Onix"),
                    GymPokemonData(id: 408, name: "Cranidos")
                ]),
                GymData(id: "sinnoh-2", name: "Gimnasio Vetusta", city: "Ciudad Vetusta", leader: "Gardenia", specialty: "Planta", badge: "Bosque", pokemons: [
                    GymPokemonData(id: 420, name: "Cherubi"),
                    GymPokemonData(id: 387, name: "Turtwig"),
                    GymPokemonData(id: 407, name: "Roserade")
                ]),
                GymData(id: "sinnoh-3", name: "Gimnasio Corazon", city: "Ciudad Corazon", leader: "Maylene", specialty: "Lucha", badge: "Adoquin", pokemons: [
                    GymPokemonData(id: 307, name: "Meditite"),
                    GymPokemonData(id: 67, name: "Machoke"),
                    GymPokemonData(id: 448, name: "Lucario")
                ]),
                GymData(id: "sinnoh-4", name: "Gimnasio Pradera", city: "Pueblo Pradera", leader: "Crasher Wake", specialty: "Agua", badge: "Cienaga", pokemons: [
                    GymPokemonData(id: 130, name: "Gyarados"),
                    GymPokemonData(id: 195, name: "Quagsire"),
                    GymPokemonData(id: 419, name: "Floatzel")
                ]),
                GymData(id: "sinnoh-5", name: "Gimnasio Fantina", city: "Ciudad Corazon", leader: "Fantina", specialty: "Fantasma", badge: "Reliquia", pokemons: [
                    GymPokemonData(id: 426, name: "Drifblim"),
                    GymPokemonData(id: 94, name: "Gengar"),
                    GymPokemonData(id: 429, name: "Mismagius")
                ]),
                GymData(id: "sinnoh-6", name: "Gimnasio Canal", city: "Ciudad Canal", leader: "Byron", specialty: "Acero", badge: "Mina", pokemons: [
                    GymPokemonData(id: 436, name: "Bronzor"),
                    GymPokemonData(id: 208, name: "Steelix"),
                    GymPokemonData(id: 411, name: "Bastiodon")
                ]),
                GymData(id: "sinnoh-7", name: "Gimnasio Puntaneva", city: "Ciudad Puntaneva", leader: "Candice", specialty: "Hielo", badge: "Tempano", pokemons: [
                    GymPokemonData(id: 459, name: "Snover"),
                    GymPokemonData(id: 215, name: "Sneasel"),
                    GymPokemonData(id: 308, name: "Medicham"),
                    GymPokemonData(id: 460, name: "Abomasnow")
                ]),
                GymData(id: "sinnoh-8", name: "Gimnasio Marina", city: "Ciudad Marina", leader: "Volkner", specialty: "Electrico", badge: "Faro", pokemons: [
                    GymPokemonData(id: 26, name: "Raichu"),
                    GymPokemonData(id: 424, name: "Ambipom"),
                    GymPokemonData(id: 224, name: "Octillery"),
                    GymPokemonData(id: 405, name: "Luxray")
                ])
            ]
        ),
        GymRegionData(
            id: "teselia",
            regionName: "Teselia",
            referenceGame: "Black/White",
            gyms: [
                GymData(id: "teselia-1", name: "Gimnasio Gres", city: "Ciudad Gres", leader: "Cilan/Chili/Cress", specialty: "Variable", badge: "Trio", pokemons: [
                    GymPokemonData(id: 506, name: "Lillipup"),
                    GymPokemonData(id: 511, name: "Pansage"),
                    GymPokemonData(id: 513, name: "Pansear"),
                    GymPokemonData(id: 515, name: "Panpour")
                ]),
                GymData(id: "teselia-2", name: "Gimnasio Esmalte", city: "Ciudad Esmalte", leader: "Lenora", specialty: "Normal", badge: "Basic", pokemons: [
                    GymPokemonData(id: 507, name: "Herdier"),
                    GymPokemonData(id: 505, name: "Watchog")
                ]),
                GymData(id: "teselia-3", name: "Gimnasio Porcelana", city: "Ciudad Porcelana", leader: "Burgh", specialty: "Bicho", badge: "Insecto", pokemons: [
                    GymPokemonData(id: 544, name: "Whirlipede"),
                    GymPokemonData(id: 557, name: "Dwebble"),
                    GymPokemonData(id: 542, name: "Leavanny")
                ]),
                GymData(id: "teselia-4", name: "Gimnasio Mayolica", city: "Ciudad Mayolica", leader: "Elesa", specialty: "Electrico", badge: "Voltio", pokemons: [
                    GymPokemonData(id: 587, name: "Emolga"),
                    GymPokemonData(id: 587, name: "Emolga"),
                    GymPokemonData(id: 523, name: "Zebstrika")
                ]),
                GymData(id: "teselia-5", name: "Gimnasio Fayenza", city: "Ciudad Fayenza", leader: "Clay", specialty: "Tierra", badge: "Terremoto", pokemons: [
                    GymPokemonData(id: 552, name: "Krokorok"),
                    GymPokemonData(id: 536, name: "Palpitoad"),
                    GymPokemonData(id: 530, name: "Excadrill")
                ]),
                GymData(id: "teselia-6", name: "Gimnasio Loza", city: "Ciudad Loza", leader: "Skyla", specialty: "Volador", badge: "Jet", pokemons: [
                    GymPokemonData(id: 528, name: "Swoobat"),
                    GymPokemonData(id: 521, name: "Unfezant"),
                    GymPokemonData(id: 581, name: "Swanna")
                ]),
                GymData(id: "teselia-7", name: "Gimnasio Teja", city: "Ciudad Teja", leader: "Brycen", specialty: "Hielo", badge: "Carambano", pokemons: [
                    GymPokemonData(id: 583, name: "Vanillish"),
                    GymPokemonData(id: 615, name: "Cryogonal"),
                    GymPokemonData(id: 614, name: "Beartic")
                ]),
                GymData(id: "teselia-8", name: "Gimnasio Caolin", city: "Ciudad Caolin", leader: "Drayden", specialty: "Dragon", badge: "Leyenda", pokemons: [
                    GymPokemonData(id: 611, name: "Fraxure"),
                    GymPokemonData(id: 621, name: "Druddigon"),
                    GymPokemonData(id: 612, name: "Haxorus")
                ])
            ]
        ),
        GymRegionData(
            id: "kalos",
            regionName: "Kalos",
            referenceGame: "X/Y",
            gyms: [
                GymData(id: "kalos-1", name: "Gimnasio Novarte", city: "Ciudad Novarte", leader: "Viola", specialty: "Bicho", badge: "Bicho", pokemons: [
                    GymPokemonData(id: 283, name: "Surskit"),
                    GymPokemonData(id: 666, name: "Vivillon")
                ]),
                GymData(id: "kalos-2", name: "Gimnasio Relieve", city: "Ciudad Relieve", leader: "Grant", specialty: "Roca", badge: "Acantilado", pokemons: [
                    GymPokemonData(id: 698, name: "Amaura"),
                    GymPokemonData(id: 696, name: "Tyrunt")
                ]),
                GymData(id: "kalos-3", name: "Gimnasio Yantra", city: "Ciudad Yantra", leader: "Korrina", specialty: "Lucha", badge: "Rumble", pokemons: [
                    GymPokemonData(id: 619, name: "Mienfoo"),
                    GymPokemonData(id: 67, name: "Machoke"),
                    GymPokemonData(id: 701, name: "Hawlucha")
                ]),
                GymData(id: "kalos-4", name: "Gimnasio Romantis", city: "Ciudad Romantis", leader: "Ramos", specialty: "Planta", badge: "Planta", pokemons: [
                    GymPokemonData(id: 189, name: "Jumpluff"),
                    GymPokemonData(id: 70, name: "Weepinbell"),
                    GymPokemonData(id: 673, name: "Gogoat")
                ]),
                GymData(id: "kalos-5", name: "Gimnasio Fluxus", city: "Ciudad Luminalia", leader: "Clemont", specialty: "Electrico", badge: "Voltaje", pokemons: [
                    GymPokemonData(id: 587, name: "Emolga"),
                    GymPokemonData(id: 82, name: "Magneton"),
                    GymPokemonData(id: 695, name: "Heliolisk")
                ]),
                GymData(id: "kalos-6", name: "Gimnasio Fresco", city: "Pueblo Fresco", leader: "Valerie", specialty: "Hada", badge: "Hada", pokemons: [
                    GymPokemonData(id: 122, name: "Mr. Mime"),
                    GymPokemonData(id: 303, name: "Mawile"),
                    GymPokemonData(id: 700, name: "Sylveon")
                ]),
                GymData(id: "kalos-7", name: "Gimnasio Romantis Psiquico", city: "Ciudad Romantis", leader: "Olympia", specialty: "Psiquico", badge: "Psiquico", pokemons: [
                    GymPokemonData(id: 561, name: "Sigilyph"),
                    GymPokemonData(id: 199, name: "Slowking"),
                    GymPokemonData(id: 678, name: "Meowstic")
                ]),
                GymData(id: "kalos-8", name: "Gimnasio Fractal", city: "Ciudad Fractal", leader: "Wulfric", specialty: "Hielo", badge: "Iceberg", pokemons: [
                    GymPokemonData(id: 460, name: "Abomasnow"),
                    GymPokemonData(id: 713, name: "Avalugg"),
                    GymPokemonData(id: 615, name: "Cryogonal")
                ])
            ]
        ),
        GymRegionData(
            id: "galar",
            regionName: "Galar",
            referenceGame: "Shield",
            gyms: [
                GymData(id: "galar-1", name: "Gimnasio Pueblo Hoyuelo", city: "Pueblo Hoyuelo", leader: "Milo", specialty: "Planta", badge: "Hierba", pokemons: [
                    GymPokemonData(id: 829, name: "Gossifleur"),
                    GymPokemonData(id: 830, name: "Eldegoss")
                ]),
                GymData(id: "galar-2", name: "Gimnasio Artejo", city: "Pueblo Artejo", leader: "Nessa", specialty: "Agua", badge: "Agua", pokemons: [
                    GymPokemonData(id: 118, name: "Goldeen"),
                    GymPokemonData(id: 846, name: "Arrokuda"),
                    GymPokemonData(id: 834, name: "Drednaw")
                ]),
                GymData(id: "galar-3", name: "Gimnasio Motor", city: "Ciudad Motor", leader: "Kabu", specialty: "Fuego", badge: "Fuego", pokemons: [
                    GymPokemonData(id: 38, name: "Ninetales"),
                    GymPokemonData(id: 59, name: "Arcanine"),
                    GymPokemonData(id: 851, name: "Centiskorch")
                ]),
                GymData(id: "galar-4", name: "Gimnasio Pueblo Cramp", city: "Pueblo Cramp", leader: "Allister", specialty: "Fantasma", badge: "Fantasma", pokemons: [
                    GymPokemonData(id: 562, name: "Yamask"),
                    GymPokemonData(id: 778, name: "Mimikyu"),
                    GymPokemonData(id: 864, name: "Cursola"),
                    GymPokemonData(id: 94, name: "Gengar")
                ]),
                GymData(id: "galar-5", name: "Gimnasio Hada", city: "Pueblo Cramp", leader: "Opal", specialty: "Hada", badge: "Hada", pokemons: [
                    GymPokemonData(id: 110, name: "Weezing"),
                    GymPokemonData(id: 303, name: "Mawile"),
                    GymPokemonData(id: 468, name: "Togekiss"),
                    GymPokemonData(id: 869, name: "Alcremie")
                ]),
                GymData(id: "galar-6", name: "Gimnasio Hielo", city: "Ciudad Auriga", leader: "Melony", specialty: "Hielo", badge: "Hielo", pokemons: [
                    GymPokemonData(id: 873, name: "Frosmoth"),
                    GymPokemonData(id: 555, name: "Darmanitan"),
                    GymPokemonData(id: 875, name: "Eiscue"),
                    GymPokemonData(id: 131, name: "Lapras")
                ]),
                GymData(id: "galar-7", name: "Gimnasio Spike", city: "Ciudad Spike", leader: "Piers", specialty: "Siniestro", badge: "Siniestro", pokemons: [
                    GymPokemonData(id: 560, name: "Scrafty"),
                    GymPokemonData(id: 687, name: "Malamar"),
                    GymPokemonData(id: 435, name: "Skuntank"),
                    GymPokemonData(id: 862, name: "Obstagoon")
                ]),
                GymData(id: "galar-8", name: "Gimnasio Puntera", city: "Ciudad Puntera", leader: "Raihan", specialty: "Dragon", badge: "Dragon", pokemons: [
                    GymPokemonData(id: 526, name: "Gigalith"),
                    GymPokemonData(id: 330, name: "Flygon"),
                    GymPokemonData(id: 844, name: "Sandaconda"),
                    GymPokemonData(id: 884, name: "Duraludon")
                ])
            ]
        ),
        GymRegionData(
            id: "paldea",
            regionName: "Paldea",
            referenceGame: "Scarlet/Violet",
            gyms: [
                GymData(id: "paldea-1", name: "Gimnasio Altamia", city: "Pueblo Altamia", leader: "Katy", specialty: "Bicho", badge: "Bicho", pokemons: [
                    GymPokemonData(id: 919, name: "Nymble"),
                    GymPokemonData(id: 917, name: "Tarountula"),
                    GymPokemonData(id: 216, name: "Teddiursa")
                ]),
                GymData(id: "paldea-2", name: "Gimnasio Leudal", city: "Ciudad Leudal", leader: "Brassius", specialty: "Planta", badge: "Planta", pokemons: [
                    GymPokemonData(id: 548, name: "Petilil"),
                    GymPokemonData(id: 928, name: "Smoliv"),
                    GymPokemonData(id: 185, name: "Sudowoodo")
                ]),
                GymData(id: "paldea-3", name: "Gimnasio Cantara", city: "Pueblo Cantara", leader: "Iono", specialty: "Electrico", badge: "Electrico", pokemons: [
                    GymPokemonData(id: 940, name: "Wattrel"),
                    GymPokemonData(id: 939, name: "Bellibolt"),
                    GymPokemonData(id: 404, name: "Luxio"),
                    GymPokemonData(id: 429, name: "Mismagius")
                ]),
                GymData(id: "paldea-4", name: "Gimnasio Marinada", city: "Pueblo Marinada", leader: "Kofu", specialty: "Agua", badge: "Agua", pokemons: [
                    GymPokemonData(id: 976, name: "Veluza"),
                    GymPokemonData(id: 961, name: "Wugtrio"),
                    GymPokemonData(id: 740, name: "Crabominable")
                ]),
                GymData(id: "paldea-5", name: "Gimnasio Medali", city: "Ciudad Medali", leader: "Larry", specialty: "Normal", badge: "Normal", pokemons: [
                    GymPokemonData(id: 775, name: "Komala"),
                    GymPokemonData(id: 982, name: "Dudunsparce"),
                    GymPokemonData(id: 398, name: "Staraptor")
                ]),
                GymData(id: "paldea-6", name: "Gimnasio Cazola", city: "Pueblo Cazola", leader: "Ryme", specialty: "Fantasma", badge: "Fantasma", pokemons: [
                    GymPokemonData(id: 354, name: "Banette"),
                    GymPokemonData(id: 778, name: "Mimikyu"),
                    GymPokemonData(id: 972, name: "Houndstone"),
                    GymPokemonData(id: 849, name: "Toxtricity")
                ]),
                GymData(id: "paldea-7", name: "Gimnasio Alfornada", city: "Ciudad Alfornada", leader: "Tulip", specialty: "Psiquico", badge: "Psiquico", pokemons: [
                    GymPokemonData(id: 981, name: "Farigiraf"),
                    GymPokemonData(id: 282, name: "Gardevoir"),
                    GymPokemonData(id: 956, name: "Espathra"),
                    GymPokemonData(id: 671, name: "Florges")
                ]),
                GymData(id: "paldea-8", name: "Gimnasio Hozkailu", city: "Pueblo Hozkailu", leader: "Grusha", specialty: "Hielo", badge: "Hielo", pokemons: [
                    GymPokemonData(id: 873, name: "Frosmoth"),
                    GymPokemonData(id: 614, name: "Beartic"),
                    GymPokemonData(id: 975, name: "Cetitan"),
                    GymPokemonData(id: 334, name: "Altaria")
                ])
            ]
        )
    ]
}

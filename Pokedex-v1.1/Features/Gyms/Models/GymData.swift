import Foundation

struct GymRegionData: Identifiable {
    let id: String
    let regionName: String
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
            gyms: [
                GymData(id: "kanto-1", name: "Gimnasio de Ciudad Plateada", city: "Ciudad Plateada", leader: "Brock", specialty: "Roca", badge: "Roca", pokemons: [
                    GymPokemonData(id: 74, name: "Geodude"),
                    GymPokemonData(id: 95, name: "Onix"),
                    GymPokemonData(id: 111, name: "Rhyhorn"),
                    GymPokemonData(id: 139, name: "Omastar"),
                    GymPokemonData(id: 141, name: "Kabutops"),
                    GymPokemonData(id: 208, name: "Steelix")
                ]),
                GymData(id: "kanto-2", name: "Gimnasio Celeste", city: "Ciudad Celeste", leader: "Misty", specialty: "Agua", badge: "Cascada", pokemons: [
                    GymPokemonData(id: 120, name: "Staryu"),
                    GymPokemonData(id: 121, name: "Starmie")
                ]),
                GymData(id: "kanto-3", name: "Gimnasio Carmin", city: "Ciudad Carmin", leader: "Lt. Surge", specialty: "Electrico", badge: "Trueno", pokemons: [
                    GymPokemonData(id: 25, name: "Pikachu"),
                    GymPokemonData(id: 26, name: "Raichu")
                ]),
                GymData(id: "kanto-4", name: "Gimnasio Azulona", city: "Ciudad Azulona", leader: "Erika", specialty: "Planta", badge: "Arcoiris", pokemons: [
                    GymPokemonData(id: 44, name: "Gloom"),
                    GymPokemonData(id: 71, name: "Victreebel")
                ]),
                GymData(id: "kanto-5", name: "Gimnasio Fucsia", city: "Ciudad Fucsia", leader: "Koga", specialty: "Veneno", badge: "Alma", pokemons: [
                    GymPokemonData(id: 109, name: "Koffing"),
                    GymPokemonData(id: 110, name: "Weezing")
                ]),
                GymData(id: "kanto-6", name: "Gimnasio Azafran", city: "Ciudad Azafran", leader: "Sabrina", specialty: "Psiquico", badge: "Pantano", pokemons: [
                    GymPokemonData(id: 64, name: "Kadabra"),
                    GymPokemonData(id: 65, name: "Alakazam")
                ]),
                GymData(id: "kanto-7", name: "Gimnasio Isla Canela", city: "Isla Canela", leader: "Blaine", specialty: "Fuego", badge: "Volcan", pokemons: [
                    GymPokemonData(id: 58, name: "Growlithe"),
                    GymPokemonData(id: 59, name: "Arcanine")
                ]),
                GymData(id: "kanto-8", name: "Gimnasio Verde", city: "Ciudad Verde", leader: "Giovanni", specialty: "Tierra", badge: "Tierra", pokemons: [
                    GymPokemonData(id: 111, name: "Rhyhorn"),
                    GymPokemonData(id: 112, name: "Rhydon")
                ])
            ]
        ),
        GymRegionData(
            id: "johto",
            regionName: "Johto",
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
                    GymPokemonData(id: 14, name: "Kakuna"),
                    GymPokemonData(id: 15, name: "Beedrill")
                ]),
                GymData(id: "johto-4", name: "Gimnasio Endrino", city: "Ciudad Endrino", leader: "Morty", specialty: "Fantasma", badge: "Niebla", pokemons: [
                    GymPokemonData(id: 92, name: "Gastly"),
                    GymPokemonData(id: 94, name: "Gengar")
                ]),
                GymData(id: "johto-5", name: "Gimnasio Orquidea", city: "Ciudad Orquidea", leader: "Chuck", specialty: "Lucha", badge: "Tormenta", pokemons: [
                    GymPokemonData(id: 62, name: "Poliwrath"),
                    GymPokemonData(id: 107, name: "Hitmonchan")
                ]),
                GymData(id: "johto-6", name: "Gimnasio Caoba", city: "Ciudad Caoba", leader: "Pryce", specialty: "Hielo", badge: "Glaciar", pokemons: [
                    GymPokemonData(id: 87, name: "Dewgong"),
                    GymPokemonData(id: 221, name: "Piloswine")
                ]),
                GymData(id: "johto-7", name: "Gimnasio Olivo", city: "Ciudad Olivo", leader: "Jasmine", specialty: "Acero", badge: "Mineral", pokemons: [
                    GymPokemonData(id: 81, name: "Magnemite"),
                    GymPokemonData(id: 208, name: "Steelix")
                ]),
                GymData(id: "johto-8", name: "Gimnasio Ebeno", city: "Ciudad Ebeno", leader: "Clair", specialty: "Dragon", badge: "Levantada", pokemons: [
                    GymPokemonData(id: 148, name: "Dragonair"),
                    GymPokemonData(id: 230, name: "Kingdra")
                ])
            ]
        ),
        GymRegionData(
            id: "hoenn",
            regionName: "Hoenn",
            gyms: [
                GymData(id: "hoenn-1", name: "Gimnasio Ferrica", city: "Ciudad Ferrica", leader: "Roxanne", specialty: "Roca", badge: "Piedra", pokemons: [
                    GymPokemonData(id: 74, name: "Geodude"),
                    GymPokemonData(id: 299, name: "Nosepass")
                ]),
                GymData(id: "hoenn-2", name: "Gimnasio Azuliza", city: "Pueblo Azuliza", leader: "Brawly", specialty: "Lucha", badge: "Puño", pokemons: [
                    GymPokemonData(id: 66, name: "Machop"),
                    GymPokemonData(id: 307, name: "Meditite")
                ]),
                GymData(id: "hoenn-3", name: "Gimnasio Malvalona", city: "Ciudad Malvalona", leader: "Wattson", specialty: "Electrico", badge: "Dinamo", pokemons: [
                    GymPokemonData(id: 82, name: "Magneton"),
                    GymPokemonData(id: 310, name: "Manectric")
                ]),
                GymData(id: "hoenn-4", name: "Gimnasio Lavacalda", city: "Pueblo Lavacalda", leader: "Flannery", specialty: "Fuego", badge: "Calor", pokemons: [
                    GymPokemonData(id: 322, name: "Numel"),
                    GymPokemonData(id: 324, name: "Torkoal")
                ]),
                GymData(id: "hoenn-5", name: "Gimnasio Petalia", city: "Ciudad Petalia", leader: "Norman", specialty: "Normal", badge: "Equilibrio", pokemons: [
                    GymPokemonData(id: 287, name: "Slakoth"),
                    GymPokemonData(id: 289, name: "Slaking")
                ]),
                GymData(id: "hoenn-6", name: "Gimnasio Arborada", city: "Ciudad Arborada", leader: "Winona", specialty: "Volador", badge: "Pluma", pokemons: [
                    GymPokemonData(id: 333, name: "Swablu"),
                    GymPokemonData(id: 334, name: "Altaria")
                ]),
                GymData(id: "hoenn-7", name: "Gimnasio Algaria", city: "Ciudad Algaria", leader: "Tate y Liza", specialty: "Psiquico", badge: "Mente", pokemons: [
                    GymPokemonData(id: 337, name: "Lunatone"),
                    GymPokemonData(id: 338, name: "Solrock")
                ]),
                GymData(id: "hoenn-8", name: "Gimnasio Arrecipolis", city: "Ciudad Arrecipolis", leader: "Wallace", specialty: "Agua", badge: "Lluvia", pokemons: [
                    GymPokemonData(id: 340, name: "Whiscash"),
                    GymPokemonData(id: 350, name: "Milotic")
                ])
            ]
        ),
        GymRegionData(
            id: "sinnoh",
            regionName: "Sinnoh",
            gyms: [
                GymData(id: "sinnoh-1", name: "Gimnasio Pirita", city: "Ciudad Pirita", leader: "Roark", specialty: "Roca", badge: "Carbon", pokemons: [
                    GymPokemonData(id: 74, name: "Geodude"),
                    GymPokemonData(id: 408, name: "Cranidos")
                ]),
                GymData(id: "sinnoh-2", name: "Gimnasio Vetusta", city: "Ciudad Vetusta", leader: "Gardenia", specialty: "Planta", badge: "Bosque", pokemons: [
                    GymPokemonData(id: 420, name: "Cherubi"),
                    GymPokemonData(id: 407, name: "Roserade")
                ]),
                GymData(id: "sinnoh-3", name: "Gimnasio Corazon", city: "Ciudad Corazon", leader: "Maylene", specialty: "Lucha", badge: "Adoquin", pokemons: [
                    GymPokemonData(id: 447, name: "Riolu"),
                    GymPokemonData(id: 448, name: "Lucario")
                ]),
                GymData(id: "sinnoh-4", name: "Gimnasio Pradera", city: "Pueblo Pradera", leader: "Crasher Wake", specialty: "Agua", badge: "Cienaga", pokemons: [
                    GymPokemonData(id: 418, name: "Buizel"),
                    GymPokemonData(id: 423, name: "Gastrodon")
                ]),
                GymData(id: "sinnoh-5", name: "Gimnasio Fantina", city: "Ciudad Corazon", leader: "Fantina", specialty: "Fantasma", badge: "Reliquia", pokemons: [
                    GymPokemonData(id: 425, name: "Drifblim"),
                    GymPokemonData(id: 429, name: "Mismagius")
                ]),
                GymData(id: "sinnoh-6", name: "Gimnasio Canal", city: "Ciudad Canal", leader: "Byron", specialty: "Acero", badge: "Mina", pokemons: [
                    GymPokemonData(id: 208, name: "Steelix"),
                    GymPokemonData(id: 411, name: "Bastiodon")
                ]),
                GymData(id: "sinnoh-7", name: "Gimnasio Puntaneva", city: "Ciudad Puntaneva", leader: "Candice", specialty: "Hielo", badge: "Tempano", pokemons: [
                    GymPokemonData(id: 460, name: "Abomasnow"),
                    GymPokemonData(id: 124, name: "Jynx")
                ]),
                GymData(id: "sinnoh-8", name: "Gimnasio Marina", city: "Ciudad Marina", leader: "Volkner", specialty: "Electrico", badge: "Faro", pokemons: [
                    GymPokemonData(id: 404, name: "Luxio"),
                    GymPokemonData(id: 405, name: "Luxray")
                ])
            ]
        ),
        GymRegionData(
            id: "teselia",
            regionName: "Teselia",
            gyms: [
                GymData(id: "teselia-1", name: "Gimnasio Gres", city: "Ciudad Gres", leader: "Cilan/Chili/Cress", specialty: "Variable", badge: "Trio", pokemons: [
                    GymPokemonData(id: 511, name: "Pansage"),
                    GymPokemonData(id: 513, name: "Pansear")
                ]),
                GymData(id: "teselia-2", name: "Gimnasio Esmalte", city: "Ciudad Esmalte", leader: "Lenora", specialty: "Normal", badge: "Basic", pokemons: [
                    GymPokemonData(id: 519, name: "Pidove"),
                    GymPokemonData(id: 531, name: "Audino")
                ]),
                GymData(id: "teselia-3", name: "Gimnasio Porcelana", city: "Ciudad Porcelana", leader: "Burgh", specialty: "Bicho", badge: "Insecto", pokemons: [
                    GymPokemonData(id: 543, name: "Venipede"),
                    GymPokemonData(id: 542, name: "Leavanny")
                ]),
                GymData(id: "teselia-4", name: "Gimnasio Mayolica", city: "Ciudad Mayolica", leader: "Elesa", specialty: "Electrico", badge: "Voltio", pokemons: [
                    GymPokemonData(id: 587, name: "Emolga"),
                    GymPokemonData(id: 523, name: "Zebstrika")
                ]),
                GymData(id: "teselia-5", name: "Gimnasio Fayenza", city: "Ciudad Fayenza", leader: "Clay", specialty: "Tierra", badge: "Terremoto", pokemons: [
                    GymPokemonData(id: 552, name: "Krokorok"),
                    GymPokemonData(id: 536, name: "Palpitoad")
                ]),
                GymData(id: "teselia-6", name: "Gimnasio Loza", city: "Ciudad Loza", leader: "Skyla", specialty: "Volador", badge: "Jet", pokemons: [
                    GymPokemonData(id: 527, name: "Woobat"),
                    GymPokemonData(id: 561, name: "Sigilyph")
                ]),
                GymData(id: "teselia-7", name: "Gimnasio Teja", city: "Ciudad Teja", leader: "Brycen", specialty: "Hielo", badge: "Carambano", pokemons: [
                    GymPokemonData(id: 613, name: "Cubchoo"),
                    GymPokemonData(id: 614, name: "Beartic")
                ]),
                GymData(id: "teselia-8", name: "Gimnasio Caolin", city: "Ciudad Caolin", leader: "Drayden", specialty: "Dragon", badge: "Leyenda", pokemons: [
                    GymPokemonData(id: 621, name: "Druddigon"),
                    GymPokemonData(id: 612, name: "Haxorus")
                ])
            ]
        ),
        GymRegionData(
            id: "kalos",
            regionName: "Kalos",
            gyms: [
                GymData(id: "kalos-1", name: "Gimnasio Novarte", city: "Ciudad Novarte", leader: "Viola", specialty: "Bicho", badge: "Bicho", pokemons: [
                    GymPokemonData(id: 664, name: "Scatterbug"),
                    GymPokemonData(id: 666, name: "Vivillon")
                ]),
                GymData(id: "kalos-2", name: "Gimnasio Relieve", city: "Ciudad Relieve", leader: "Grant", specialty: "Roca", badge: "Acantilado", pokemons: [
                    GymPokemonData(id: 696, name: "Tyrunt"),
                    GymPokemonData(id: 699, name: "Aurorus")
                ]),
                GymData(id: "kalos-3", name: "Gimnasio Yantra", city: "Ciudad Yantra", leader: "Korrina", specialty: "Lucha", badge: "Rumble", pokemons: [
                    GymPokemonData(id: 619, name: "Mienfoo"),
                    GymPokemonData(id: 448, name: "Lucario")
                ]),
                GymData(id: "kalos-4", name: "Gimnasio Romantis", city: "Ciudad Romantis", leader: "Ramos", specialty: "Planta", badge: "Planta", pokemons: [
                    GymPokemonData(id: 188, name: "Skiploom"),
                    GymPokemonData(id: 709, name: "Trevenant")
                ]),
                GymData(id: "kalos-5", name: "Gimnasio Fluxus", city: "Ciudad Luminalia", leader: "Clemont", specialty: "Electrico", badge: "Voltaje", pokemons: [
                    GymPokemonData(id: 702, name: "Dedenne"),
                    GymPokemonData(id: 695, name: "Heliolisk")
                ]),
                GymData(id: "kalos-6", name: "Gimnasio Fresco", city: "Pueblo Fresco", leader: "Valerie", specialty: "Hada", badge: "Hada", pokemons: [
                    GymPokemonData(id: 682, name: "Spritzee"),
                    GymPokemonData(id: 671, name: "Florges")
                ]),
                GymData(id: "kalos-7", name: "Gimnasio Romantis Psiquico", city: "Ciudad Romantis", leader: "Olympia", specialty: "Psiquico", badge: "Psiquico", pokemons: [
                    GymPokemonData(id: 678, name: "Meowstic"),
                    GymPokemonData(id: 561, name: "Sigilyph")
                ]),
                GymData(id: "kalos-8", name: "Gimnasio Fractal", city: "Ciudad Fractal", leader: "Wulfric", specialty: "Hielo", badge: "Iceberg", pokemons: [
                    GymPokemonData(id: 615, name: "Cryogonal"),
                    GymPokemonData(id: 713, name: "Avalugg")
                ])
            ]
        ),
        GymRegionData(
            id: "galar",
            regionName: "Galar",
            gyms: [
                GymData(id: "galar-1", name: "Gimnasio Pueblo Hoyuelo", city: "Pueblo Hoyuelo", leader: "Milo", specialty: "Planta", badge: "Hierba", pokemons: [
                    GymPokemonData(id: 761, name: "Bounsweet"),
                    GymPokemonData(id: 829, name: "Gossifleur")
                ]),
                GymData(id: "galar-2", name: "Gimnasio Artejo", city: "Pueblo Artejo", leader: "Nessa", specialty: "Agua", badge: "Agua", pokemons: [
                    GymPokemonData(id: 834, name: "Drednaw"),
                    GymPokemonData(id: 117, name: "Seadra")
                ]),
                GymData(id: "galar-3", name: "Gimnasio Motor", city: "Ciudad Motor", leader: "Kabu", specialty: "Fuego", badge: "Fuego", pokemons: [
                    GymPokemonData(id: 607, name: "Litwick"),
                    GymPokemonData(id: 851, name: "Centiskorch")
                ]),
                GymData(id: "galar-4", name: "Gimnasio Lucha/Fantasma", city: "Pueblo Cramp", leader: "Bea/Allister", specialty: "Lucha/Fantasma", badge: "Lucha", pokemons: [
                    GymPokemonData(id: 853, name: "Grapploct"),
                    GymPokemonData(id: 855, name: "Polteageist")
                ]),
                GymData(id: "galar-5", name: "Gimnasio Hada", city: "Pueblo Cramp", leader: "Opal", specialty: "Hada", badge: "Hada", pokemons: [
                    GymPokemonData(id: 778, name: "Mimikyu"),
                    GymPokemonData(id: 869, name: "Alcremie")
                ]),
                GymData(id: "galar-6", name: "Gimnasio Spike", city: "Ciudad Spike", leader: "Piers", specialty: "Siniestro", badge: "Siniestro", pokemons: [
                    GymPokemonData(id: 861, name: "Grimmsnarl"),
                    GymPokemonData(id: 510, name: "Liepard")
                ]),
                GymData(id: "galar-7", name: "Gimnasio Hielo", city: "Pueblo Auriga", leader: "Melony", specialty: "Hielo", badge: "Hielo", pokemons: [
                    GymPokemonData(id: 712, name: "Bergmite"),
                    GymPokemonData(id: 713, name: "Avalugg")
                ]),
                GymData(id: "galar-8", name: "Gimnasio Puntera", city: "Ciudad Puntera", leader: "Raihan", specialty: "Dragon", badge: "Dragon", pokemons: [
                    GymPokemonData(id: 330, name: "Flygon"),
                    GymPokemonData(id: 884, name: "Duraludon")
                ])
            ]
        ),
        GymRegionData(
            id: "paldea",
            regionName: "Paldea",
            gyms: [
                GymData(id: "paldea-1", name: "Gimnasio Altamia", city: "Pueblo Altamia", leader: "Katy", specialty: "Bicho", badge: "Bicho", pokemons: [
                    GymPokemonData(id: 919, name: "Nymble"),
                    GymPokemonData(id: 917, name: "Tarountula")
                ]),
                GymData(id: "paldea-2", name: "Gimnasio Leudal", city: "Ciudad Leudal", leader: "Brassius", specialty: "Planta", badge: "Planta", pokemons: [
                    GymPokemonData(id: 929, name: "Smoliv"),
                    GymPokemonData(id: 930, name: "Arboliva")
                ]),
                GymData(id: "paldea-3", name: "Gimnasio Cantara", city: "Pueblo Cantara", leader: "Iono", specialty: "Electrico", badge: "Electrico", pokemons: [
                    GymPokemonData(id: 938, name: "Tadbulb"),
                    GymPokemonData(id: 939, name: "Bellibolt")
                ]),
                GymData(id: "paldea-4", name: "Gimnasio Marinada", city: "Pueblo Marinada", leader: "Kofu", specialty: "Agua", badge: "Agua", pokemons: [
                    GymPokemonData(id: 963, name: "Finizen"),
                    GymPokemonData(id: 977, name: "Dondozo")
                ]),
                GymData(id: "paldea-5", name: "Gimnasio Medali", city: "Ciudad Medali", leader: "Larry", specialty: "Normal", badge: "Normal", pokemons: [
                    GymPokemonData(id: 203, name: "Girafarig"),
                    GymPokemonData(id: 982, name: "Dudunsparce")
                ]),
                GymData(id: "paldea-6", name: "Gimnasio Cazola", city: "Pueblo Cazola", leader: "Ryme", specialty: "Fantasma", badge: "Fantasma", pokemons: [
                    GymPokemonData(id: 971, name: "Greavard"),
                    GymPokemonData(id: 972, name: "Houndstone")
                ]),
                GymData(id: "paldea-7", name: "Gimnasio Alfornada", city: "Ciudad Alfornada", leader: "Tulip", specialty: "Psiquico", badge: "Psiquico", pokemons: [
                    GymPokemonData(id: 956, name: "Espathra"),
                    GymPokemonData(id: 955, name: "Flittle")
                ]),
                GymData(id: "paldea-8", name: "Gimnasio Hozkailu", city: "Pueblo Hozkailu", leader: "Grusha", specialty: "Hielo", badge: "Hielo", pokemons: [
                    GymPokemonData(id: 975, name: "Cetitan"),
                    GymPokemonData(id: 978, name: "Tatsugiri")
                ])
            ]
        )
    ]
}

import XCTest
@testable import Pokedex_v1_1

final class PokemonDisplayTextTests: XCTestCase {
    func testLocalizedTypeTranslatesKnownTypesToSpanish() {
        XCTAssertEqual(PokemonDisplayText.localizedType("fire"), "Fuego")
        XCTAssertEqual(PokemonDisplayText.localizedType("electric"), "Eléctrico")
        XCTAssertEqual(PokemonDisplayText.localizedType("dragon"), "Dragón")
    }

    func testLocalizedTypeFallsBackToCapitalizedValueForUnknownTypes() {
        XCTAssertEqual(PokemonDisplayText.localizedType("stellar"), "Stellar")
    }

    func testLocalizedStatTranslatesKnownStatsToSpanish() {
        XCTAssertEqual(PokemonDisplayText.localizedStat("hp"), "PS")
        XCTAssertEqual(PokemonDisplayText.localizedStat("special-attack"), "Ataque Especial")
        XCTAssertEqual(PokemonDisplayText.localizedStat("speed"), "Velocidad")
    }
}

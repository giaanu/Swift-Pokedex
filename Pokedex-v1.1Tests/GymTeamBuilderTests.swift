import XCTest
@testable import Pokedex_v1_1

final class GymTeamBuilderTests: XCTestCase {
    func testFullTeamCompletesUpToSixPokemonWithoutReplacingOriginalOnes() {
        let gym = GymData(
            id: "test-electric",
            name: "Gimnasio Test",
            city: "Ciudad Test",
            leader: "Lt. Test",
            specialty: "Electrico",
            badge: "Voltio",
            pokemons: [
                GymPokemonData(id: 25, name: "Pikachu"),
                GymPokemonData(id: 100, name: "Voltorb")
            ]
        )

        let team = GymTeamBuilder.fullTeam(for: gym)

        XCTAssertEqual(team.count, 6)
        XCTAssertEqual(Array(team.prefix(2)).map(\.id), [25, 100])
        XCTAssertEqual(Set(team.map(\.id)).count, team.count)
    }

    func testFullTeamFallsBackToGenericPoolForUnknownSpecialty() {
        let gym = GymData(
            id: "test-variable",
            name: "Gimnasio Test",
            city: "Ciudad Test",
            leader: "Lider Test",
            specialty: "Variable",
            badge: "Trio",
            pokemons: []
        )

        let team = GymTeamBuilder.fullTeam(for: gym)

        XCTAssertEqual(team.count, 6)
        XCTAssertEqual(team.map(\.id), [25, 94, 149, 448, 700, 6])
    }
}

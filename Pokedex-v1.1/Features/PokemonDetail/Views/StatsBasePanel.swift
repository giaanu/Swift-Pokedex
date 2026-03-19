import SwiftUI

struct StatsBasePanel: View {
    let stats: [PokemonStatEntry]

    var body: some View {
        VStack(spacing: 16) {

            // Bajamos todo para no tapar el círculo
            Spacer()
                .frame(height: 40)

            Text("STATS BASE")
                .font(.title2.bold())
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .center)

            VStack(spacing: 12) {
                ForEach(stats, id: \.stat.name) { stat in
                    StatBar(
                        name: statName(stat.stat.name),
                        value: stat.base_stat
                    )
                }
            }
        }
        .padding(.horizontal, 28)
        .frame(maxWidth: .infinity)
    }
    private func statName(_ raw: String) -> String {
        switch raw {
        case "hp": return "HP"
        case "attack": return "ATK"
        case "defense": return "DEF"
        case "special-attack": return "SP. ATK"
        case "special-defense": return "SP. DEF"
        case "speed": return "SPD"
        default: return raw.uppercased()
        }
    }
}

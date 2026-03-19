import SwiftUI

struct DamageRelationsPanel: View {
    let weaknesses: [(type: String, multiplier: Double)]
    let resistances: [(type: String, multiplier: Double)]
    let immunities: [String]

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {

                // 🔴 DEBILIDADES
                if !weaknesses.isEmpty {
                    SectionView(
                        title: "Debilidades",
                        items: weaknesses,
                        color: .red
                    )
                }

                // 🟢 RESISTENCIAS
                if !resistances.isEmpty {
                    SectionView(
                        title: "Resistencias",
                        items: resistances,
                        color: .green
                    )
                }

                // ⚪ INMUNIDADES (si existieran)
                if !immunities.isEmpty {
                    SectionView(
                        title: "Inmunidades",
                        items: immunities.map { ($0, 0) },
                        color: .gray
                    )
                }
            }
            .padding(.top, 32)        // 🔽 baja todo debajo de la línea punteada
            .padding(.horizontal, 24)
            .padding(.bottom, 24)     // 🔼 aire abajo
            .frame(maxWidth: .infinity, alignment: .top)
        }
        .frame(maxWidth: .infinity)
    }
}

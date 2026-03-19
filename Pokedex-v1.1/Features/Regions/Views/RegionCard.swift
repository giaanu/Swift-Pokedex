import SwiftUI

struct RegionCard: View {
    let region: Region

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(region.name.uppercased())
                    .font(DSTypography.sectionTitle)
                    .foregroundColor(DSColors.accent)

                Text("\(region.pokedexRange.lowerBound)–\(region.pokedexRange.upperBound)")
                    .font(.caption.bold())
                    .foregroundColor(DSColors.accent)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundColor(DSColors.textSecondary)
        }
        .padding()
        .background(
            // 👇 material sin bordes visibles
            RoundedRectangle(cornerRadius: 12)
                .fill(.ultraThinMaterial)
                .opacity(0.7)
        )
        .shadow(color: DSColors.menuScrim.opacity(0.52), radius: 6, x: 0, y: 3)
    }
}

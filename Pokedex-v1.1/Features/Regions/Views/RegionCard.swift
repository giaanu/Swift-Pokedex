import SwiftUI

struct RegionCard: View {
    let region: Region

    var body: some View {
        HStack(spacing: 14) {
            RoundedRectangle(cornerRadius: 2)
                .fill(DSColors.accent)
                .frame(width: 3)

            VStack(alignment: .leading, spacing: 4) {
                Text(region.name.uppercased())
                    .font(DSTypography.sectionTitle)
                    .foregroundColor(DSColors.textPrimary)

                Text("#\(region.pokedexRange.lowerBound) – #\(region.pokedexRange.upperBound)")
                    .font(.system(.caption, design: .rounded).weight(.semibold))
                    .foregroundColor(DSColors.textSecondary)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .font(.caption.bold())
                .foregroundColor(DSColors.accent)
        }
        .padding(.vertical, 14)
        .padding(.horizontal, 16)
        .background(
            RoundedRectangle(cornerRadius: DSSpacing.cornerMedium)
                .fill(.ultraThinMaterial)
                .opacity(0.82)
        )
        .shadow(color: DSColors.accentStrong.opacity(0.18), radius: 6, x: 0, y: 3)
    }
}

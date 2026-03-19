import SwiftUI

struct MultiplierChip: View {
    let type: String

    var body: some View {
        Text(type.capitalized)
            .font(.system(size: 14, weight: .semibold))
            .foregroundColor(.white)
            .padding(.horizontal, 14)
            .padding(.vertical, 8)
            .background(typeColor.opacity(0.95))
            .clipShape(Capsule())
            .lineLimit(1)
            .fixedSize(horizontal: true, vertical: false)
    }

    private var typeColor: Color {
        PokemonTypeColor.color(for: type)
    }
}

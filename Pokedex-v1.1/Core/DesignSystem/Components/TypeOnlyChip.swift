import SwiftUI

struct TypeOnlyChip: View {

    let type: String

    var body: some View {
        Text(type.capitalized)
            .font(.system(size: 14, weight: .bold))
            .foregroundColor(.white)
            .padding(.vertical, 6)
            .padding(.horizontal, 14)
            .background(typeColor(type))
            .clipShape(Capsule())
    }

    private func typeColor(_ type: String) -> Color {
        switch type.lowercased() {
        case "fire": return .red
        case "water": return .blue
        case "grass": return .green
        case "electric": return .yellow
        case "ice": return .cyan
        case "fighting": return .orange
        case "poison": return .purple
        case "ground": return .brown
        case "flying": return .indigo
        case "psychic": return .pink
        case "bug": return .mint
        case "fairy": return .pink.opacity(0.8)
        default: return .gray
        }
    }
}

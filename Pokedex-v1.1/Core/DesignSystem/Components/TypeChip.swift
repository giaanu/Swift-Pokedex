import SwiftUI

struct TypeChip: View {

    let type: String

    var body: some View {
        Text(type.capitalized)
            .font(.caption.bold())
            .foregroundColor(.white)
            .padding(.horizontal, 10)
            .padding(.vertical, 4)
            .background(typeColor.opacity(0.9))
            .clipShape(Capsule())
    }

    private var typeColor: Color {
        switch type {
        case "fire": return .red
        case "water": return .blue
        case "grass": return .green
        case "electric": return .yellow
        case "poison": return .purple
        case "flying": return .indigo
        default: return .gray
        }
    }
}

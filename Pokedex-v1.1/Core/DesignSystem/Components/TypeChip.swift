import SwiftUI

enum TypeBadgeSize {
    case small
    case medium
}

struct TypeChip: View {

    let type: String
    var size: TypeBadgeSize = .small

    var body: some View {
        Text(PokemonDisplayText.localizedType(type))
            .font(size == .small ? .caption.bold() : .system(size: 14, weight: .bold))
            .foregroundColor(.white)
            .padding(.horizontal, size == .small ? 10 : 14)
            .padding(.vertical, size == .small ? 4 : 6)
            .background(PokemonTypeColor.color(for: type).opacity(0.92))
            .clipShape(Capsule())
            .shadow(color: PokemonTypeColor.color(for: type).opacity(0.35), radius: 4, x: 0, y: 2)
    }
}

import SwiftUI

struct ChipSection: View {

    let title: String
    let titleColor: Color
    let items: [String]
    let animate: Bool

    private let columns = [
        GridItem(.adaptive(minimum: 90), spacing: 12)
    ]

    var body: some View {
        VStack(spacing: 14) {

            // Título
            Text(title)
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(titleColor)

            // Chips
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(items.indices, id: \.self) { index in
                    TypeOnlyChip(type: items[index])
                        .opacity(animate ? 1 : 0)
                        .offset(y: animate ? 0 : 14)
                        .animation(
                            .easeOut(duration: 0.35)
                                .delay(Double(index) * 0.06),
                            value: animate
                        )
                }
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white.opacity(0.18))
        )
    }
}

import SwiftUI

struct SectionView: View {
    let title: String
    let items: [(type: String, multiplier: Double)]
    let color: Color

    var body: some View {
        VStack(spacing: 10) {

            Text(title.uppercased())
                .font(.headline.bold())
                .foregroundColor(color)
                .frame(maxWidth: .infinity, alignment: .center)

            // ✅ WrapView recibe [String] (Hashable)
            let types: [String] = items.map { $0.type }

            WrapView(items: types) { type in
               // let mult = items.first(where: { $0.type == type })?.multiplier ?? 1.0
                MultiplierChip(type: type)
            }
        }
    }
}

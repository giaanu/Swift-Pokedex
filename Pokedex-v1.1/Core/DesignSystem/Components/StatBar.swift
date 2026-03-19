import SwiftUI

struct StatBar: View {
    let name: String
    let value: Int

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(name)
                    .font(.caption.bold())
                Spacer()
                Text("\(value)")
                    .font(.caption)
            }

            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(Color.gray.opacity(0.25))
                        .frame(height: 6)

                    Capsule()
                        .fill(Color.green)
                        .frame(
                            width: geo.size.width * min(CGFloat(value) / 150, 1),
                            height: 6
                        )
                }
            }
            .frame(height: 6)
        }
    }
}

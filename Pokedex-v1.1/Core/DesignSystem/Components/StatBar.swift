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
                    .font(.system(.caption, design: .rounded).weight(.bold))
            }

            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(Color.gray.opacity(0.20))
                        .frame(height: 6)

                    Capsule()
                        .fill(barColor)
                        .frame(
                            width: geo.size.width * min(CGFloat(value) / 150, 1),
                            height: 6
                        )
                }
            }
            .frame(height: 6)
        }
    }

    private var barColor: Color {
        switch value {
        case ..<50:  return Color(red: 0.95, green: 0.35, blue: 0.25)
        case 50..<80: return Color(red: 0.97, green: 0.70, blue: 0.18)
        default:     return Color(red: 0.35, green: 0.75, blue: 0.40)
        }
    }
}

import SwiftUI

struct MiniStatBar: View {

    let value: Int
    let color: Color

    var body: some View {
        Capsule()
            .fill(color)
            .frame(width: 8, height: CGFloat(min(value, 100)))
            .opacity(0.9)
    }
}

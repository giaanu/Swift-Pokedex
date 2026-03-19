import SwiftUI

struct DPadView: View {

    let onDirection: (DPadDirection) -> Void

    private let threshold: CGFloat = 40

    var body: some View {
        Rectangle()
            .fill(Color.clear) // ⬅️ invisible pero táctil
            .contentShape(Rectangle())
            .gesture(
                DragGesture(minimumDistance: 10)
                    .onEnded { value in
                        let dx = value.translation.width
                        let dy = value.translation.height

                        if abs(dx) > abs(dy) {
                            if dx > threshold {
                                onDirection(.right)
                            } else if dx < -threshold {
                                onDirection(.left)
                            }
                        } else {
                            if dy > threshold {
                                onDirection(.down)
                            } else if dy < -threshold {
                                onDirection(.up)
                            }
                        }
                    }
            )
    }
}

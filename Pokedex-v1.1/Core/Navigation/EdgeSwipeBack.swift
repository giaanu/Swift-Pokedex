import SwiftUI

struct EdgeSwipeBack: ViewModifier {
    let dismiss: () -> Void
    @State private var startX: CGFloat? = nil

    func body(content: Content) -> some View {
        content
            .simultaneousGesture(
                DragGesture(minimumDistance: 10, coordinateSpace: .global)
                    .onChanged { value in
                        if startX == nil {
                            startX = value.startLocation.x
                        }
                    }
                    .onEnded { value in
                        defer { startX = nil }

                        guard let sx = startX, sx < 25 else { return }

                        if value.translation.width > 90, abs(value.translation.height) < 40 {
                            dismiss()
                        }
                    }
            )
    }
}

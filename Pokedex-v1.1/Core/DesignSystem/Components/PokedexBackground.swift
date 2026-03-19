import SwiftUI

struct PokedexBackground<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color(red: 0.45, green: 0.02, blue: 0.11),
                    Color(red: 0.63, green: 0.05, blue: 0.16),
                    Color(red: 0.51, green: 0.03, blue: 0.13)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            RadialGradient(
                colors: [
                    Color.white.opacity(0.18),
                    Color.clear
                ],
                center: .topLeading,
                startRadius: 20,
                endRadius: 380
            )
            .ignoresSafeArea()

            Image("pokedex_bg")
                .resizable()
                .scaledToFill()
                .opacity(0.18)
                .blendMode(.overlay)
                .ignoresSafeArea()

            GeometryReader { proxy in
                let width = proxy.size.width
                let height = proxy.size.height

                ZStack {
                    RoundedRectangle(cornerRadius: 220)
                        .fill(
                            LinearGradient(
                                colors: [
                                    Color.white.opacity(0.26),
                                    Color.white.opacity(0.04),
                                    Color.clear
                                ],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .frame(width: width * 0.34, height: height * 1.2)
                        .rotationEffect(.degrees(18))
                        .offset(x: width * 0.34, y: -height * 0.06)

                    RoundedRectangle(cornerRadius: 220)
                        .fill(
                            LinearGradient(
                                colors: [
                                    Color.white.opacity(0.18),
                                    Color.clear
                                ],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .frame(width: width * 0.18, height: height * 1.1)
                        .rotationEffect(.degrees(20))
                        .offset(x: width * 0.24, y: height * 0.02)
                }
            }
            .allowsHitTesting(false)

            Color.black.opacity(0.12)
                .ignoresSafeArea()

            content
        }
    }
}

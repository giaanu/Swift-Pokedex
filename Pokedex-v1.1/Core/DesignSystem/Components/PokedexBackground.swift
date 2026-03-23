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
                    Color(red: 0.96, green: 0.91, blue: 0.83),
                    Color(red: 0.93, green: 0.84, blue: 0.76),
                    Color(red: 0.82, green: 0.31, blue: 0.27)
                ],
                startPoint: .top,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            GeometryReader { proxy in
                let width = proxy.size.width
                let height = proxy.size.height

                ZStack {
                    Circle()
                        .fill(
                            Color(red: 0.74, green: 0.18, blue: 0.17).opacity(0.22)
                        )
                        .frame(width: width * 0.78)
                        .blur(radius: 10)
                        .offset(x: width * 0.36, y: -height * 0.18)

                    Circle()
                        .fill(
                            Color(red: 0.97, green: 0.70, blue: 0.25).opacity(0.18)
                        )
                        .frame(width: width * 0.62)
                        .blur(radius: 18)
                        .offset(x: -width * 0.34, y: height * 0.08)

                    RoundedRectangle(cornerRadius: 220)
                        .fill(Color.white.opacity(0.16))
                        .frame(width: width * 0.20, height: height * 1.12)
                        .rotationEffect(.degrees(22))
                        .offset(x: width * 0.30, y: -height * 0.03)

                    RoundedRectangle(cornerRadius: 220)
                        .fill(Color.white.opacity(0.10))
                        .frame(width: width * 0.12, height: height * 1.00)
                        .rotationEffect(.degrees(20))
                        .offset(x: width * 0.16, y: height * 0.06)

                    VStack(spacing: height * 0.12) {
                        ForEach(0..<6, id: \.self) { _ in
                            Rectangle()
                                .fill(Color.white.opacity(0.09))
                                .frame(height: 1)
                        }
                    }
                    .padding(.horizontal, 24)

                    VStack {
                        HStack(spacing: 22) {
                            ForEach(0..<5, id: \.self) { _ in
                                Circle()
                                    .stroke(Color.white.opacity(0.12), lineWidth: 1)
                                    .frame(width: width * 0.22)
                            }
                        }
                        Spacer()
                    }
                    .offset(y: -height * 0.10)
                }
            }
            .allowsHitTesting(false)

            Image("pokedex_bg")
                .resizable()
                .scaledToFill()
                .opacity(0.07)
                .blendMode(.softLight)
                .ignoresSafeArea()

            LinearGradient(
                colors: [
                    Color.white.opacity(0.10),
                    Color.clear,
                    Color.black.opacity(0.10)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
                .ignoresSafeArea()

            content
        }
    }
}

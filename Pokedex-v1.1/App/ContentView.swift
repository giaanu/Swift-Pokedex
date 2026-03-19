import SwiftUI

struct ContentView: View {
    @State private var showSplash = true
    @State private var pulseLogo = false

    var body: some View {
        NavigationStack {
            ZStack {
                RegionListView()
                    .opacity(showSplash ? 0 : 1)

                if showSplash {
                    SplashIntroView(pulseLogo: pulseLogo)
                        .transition(.opacity)
                }
            }
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 0.65).repeatCount(1, autoreverses: true)) {
                pulseLogo = true
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.95) {
                withAnimation(.easeOut(duration: 0.28)) {
                    showSplash = false
                }
            }
        }
    }
}

private struct SplashIntroView: View {
    let pulseLogo: Bool

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color(red: 0.45, green: 0.02, blue: 0.11),
                    Color(red: 0.63, green: 0.05, blue: 0.16)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 20) {
                Image("launch_logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 130, height: 130)
                    .scaleEffect(pulseLogo ? 1.08 : 0.95)
                    .shadow(color: .white.opacity(0.28), radius: 16, x: 0, y: 0)

                Text("Pokedex")
                    .font(.title.bold())
                    .foregroundColor(.white.opacity(0.95))
            }
        }
    }
}

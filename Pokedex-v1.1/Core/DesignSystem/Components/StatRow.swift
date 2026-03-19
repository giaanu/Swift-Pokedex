import SwiftUI

struct StatRow: View {

    let name: String
    let value: Int
    let animate: Bool
    let delay: Double

    @State private var progress: CGFloat = 0
    @State private var showGlow = false

    var body: some View {
        HStack(spacing: 10) {

            // Nombre del stat
            Text(name)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.black)
                .frame(width: 120, alignment: .leading)

            // Barra
            GeometryReader { geo in
                ZStack(alignment: .leading) {

                    Capsule()
                        .fill(Color.black.opacity(0.18))
                        .frame(height: 6)

                    Capsule()
                        .fill(Color.green)
                        .frame(
                            width: geo.size.width * progress,
                            height: 6
                        )
                        // ✨ GLOW
                        .shadow(
                            color: showGlow ? Color.green.opacity(0.9) : .clear,
                            radius: showGlow ? 6 : 0
                        )
                        .overlay(
                            Capsule()
                                .stroke(
                                    Color.green.opacity(showGlow ? 0.9 : 0),
                                    lineWidth: 1
                                )
                        )
                }
            }
            .frame(height: 6)

            // Valor numérico
            Text("\(value)")
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(.black)
                .frame(width: 32, alignment: .trailing)
        }
        .frame(height: 18)
        .onAppear {
            runAnimation()
        }
        .onChange(of: animate) { _, _ in
            runAnimation()
        }
    }

    // MARK: - Animation Logic

    private func runAnimation() {
        guard animate else {
            progress = 0
            showGlow = false
            return
        }

        progress = 0
        showGlow = false

        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            withAnimation(.easeOut(duration: 0.6)) {
                progress = min(CGFloat(value) / 120.0, 1.0)
            }

            // ✨ Glow al finalizar
            DispatchQueue.main.asyncAfter(deadline: .now() + delay + 0.6) {
                showGlow = true

                // Fade out del glow
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    withAnimation(.easeOut(duration: 0.4)) {
                        showGlow = false
                    }
                }
            }
        }
    }
}

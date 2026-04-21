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

            Text(name)
                .font(DSTypography.statName)
                .foregroundColor(.black)
                .frame(width: 120, alignment: .leading)

            GeometryReader { geo in
                ZStack(alignment: .leading) {

                    Capsule()
                        .fill(Color.black.opacity(0.12))
                        .frame(height: 6)

                    Capsule()
                        .fill(barColor)
                        .frame(
                            width: geo.size.width * progress,
                            height: 6
                        )
                        .shadow(
                            color: showGlow ? barColor.opacity(0.85) : .clear,
                            radius: showGlow ? 6 : 0
                        )
                        .overlay(
                            Capsule()
                                .stroke(
                                    barColor.opacity(showGlow ? 0.9 : 0),
                                    lineWidth: 1
                                )
                        )
                }
            }
            .frame(height: 6)

            Text("\(value)")
                .font(DSTypography.statValue)
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

    private var barColor: Color {
        switch value {
        case ..<50:  return Color(red: 0.95, green: 0.35, blue: 0.25)
        case 50..<80: return Color(red: 0.97, green: 0.70, blue: 0.18)
        default:     return Color(red: 0.35, green: 0.75, blue: 0.40)
        }
    }

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

            DispatchQueue.main.asyncAfter(deadline: .now() + delay + 0.6) {
                showGlow = true

                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    withAnimation(.easeOut(duration: 0.4)) {
                        showGlow = false
                    }
                }
            }
        }
    }
}

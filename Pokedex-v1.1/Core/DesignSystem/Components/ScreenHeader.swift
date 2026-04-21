import SwiftUI

struct ScreenHeader: View {
    let title: String
    let subtitle: String
    let onMenuTap: () -> Void

    var body: some View {
        HStack(alignment: .top) {
            Button(action: onMenuTap) {
                Image(systemName: "line.3.horizontal")
                    .font(DSTypography.menuIcon)
                    .foregroundColor(.white)
                    .frame(width: 44, height: 44)
                    .background(Circle().fill(DSColors.accentStrong))
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 4) {
                Text(title)
                    .font(DSTypography.screenTitle)
                    .foregroundColor(DSColors.textPrimary)

                Text(subtitle)
                    .font(DSTypography.screenSubtitle)
                    .foregroundColor(DSColors.accent)
            }
        }
        .padding(.top, DSSpacing.sectionTop)
        .padding(.horizontal, DSSpacing.xLarge)
    }
}

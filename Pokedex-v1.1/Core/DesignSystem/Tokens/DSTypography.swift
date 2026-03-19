import SwiftUI

enum DSTypography {
    static let screenTitle: Font = .largeTitle.bold()
    static let screenSubtitle: Font = .subheadline

    static let sectionTitle: Font = .headline.bold()
    static let bodyStrong: Font = .body.weight(.semibold)

    static let menuTitle: Font = .title2.bold()
    static let menuItem: Font = .headline
    static let menuIcon: Font = .system(size: 20, weight: .bold)

    static let gymTitle: Font = .title.bold()
    static let trainerTitle: Font = .title3.weight(.bold)

    static let statsTitle: Font = .system(size: 22, weight: .bold)
    static let cardTitle: Font = .footnote.bold()
}

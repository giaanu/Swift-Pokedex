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

    // Rounded variants — for names, numbers, stat values
    static let pokemonName: Font = .system(size: 34, weight: .black, design: .rounded)
    static let statValue: Font = .system(size: 14, weight: .bold, design: .rounded)
    static let statName: Font = .system(size: 14, weight: .semibold, design: .default)
    static let numberLabel: Font = .system(size: 14, weight: .semibold, design: .rounded)
}

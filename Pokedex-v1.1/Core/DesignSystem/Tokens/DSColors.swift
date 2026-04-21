import SwiftUI

enum DSColors {
    static let textPrimary = Color.black
    static let textSecondary = Color.secondary

    // Warm amber accent — harmonizes with the burgundy/beige gradient
    static let accent = Color(red: 0.97, green: 0.68, blue: 0.18)
    static let accentStrong = Color(red: 0.92, green: 0.56, blue: 0.10)

    static let menuScrim = Color.black.opacity(0.35)

    static let glassSoft = Color.white.opacity(0.15)
    static let glassMedium = Color.white.opacity(0.22)
    static let glassStrong = Color.white.opacity(0.62)
    static let glassBorderSoft = Color.white.opacity(0.18)
    static let glassBorderStrong = Color.white.opacity(0.55)

    static let searchFieldBackground = Color.white.opacity(0.9)
    static let resultRowBackground = Color.white.opacity(0.85)
    static let sideMenuBackground = Color.white.opacity(0.97)
}

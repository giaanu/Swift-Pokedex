import Foundation

extension Double {
    var clean: String {
        self == floor(self)
        ? String(format: "%.0f", self)
        : String(self)
    }
}

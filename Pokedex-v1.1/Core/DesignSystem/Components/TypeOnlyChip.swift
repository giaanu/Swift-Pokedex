import SwiftUI

struct TypeOnlyChip: View {

    let type: String

    var body: some View {
        TypeChip(type: type, size: .medium)
    }
}

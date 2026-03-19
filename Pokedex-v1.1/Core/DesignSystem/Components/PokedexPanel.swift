import SwiftUI

struct PokedexPanel<Content: View>: View {
    let title: String
    let content: Content

    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title.uppercased())
                .font(.caption.bold())
                .foregroundColor(.secondary)

            content
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(14)
    }
}


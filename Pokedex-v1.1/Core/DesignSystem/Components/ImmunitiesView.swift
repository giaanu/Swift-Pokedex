import SwiftUI

struct ImmunitiesView: View {
    let types: [String]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("INMUNIDADES")
                .font(.caption.bold())
                .foregroundColor(.secondary)

            LazyVGrid(columns: [GridItem(.adaptive(minimum: 90))], spacing: 8) {
                ForEach(types, id: \.self) { type in
                    HStack(spacing: 4) {
                        Text(type.capitalized)
                        Text("x0")
                    }
                    .font(.caption.bold())
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(PokemonTypeColor.color(for: type))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
            }
        }
    }
}

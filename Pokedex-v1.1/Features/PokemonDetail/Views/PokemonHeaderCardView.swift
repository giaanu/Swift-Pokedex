import SwiftUI

struct PokemonHeaderCardView: View {
    let presenter: PokemonInfoPresenter

    var body: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 30)
                .fill(
                    LinearGradient(
                        colors: [
                            Color.white.opacity(0.94),
                            presenter.primaryTypeColor.opacity(0.22),
                            Color.white.opacity(0.90)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(Color.white.opacity(0.70), lineWidth: 1.2)
                )
                .shadow(color: Color.black.opacity(0.14), radius: 18, x: 0, y: 12)

            Circle()
                .fill(presenter.primaryTypeColor.opacity(0.20))
                .frame(width: 220, height: 220)
                .blur(radius: 4)
                .offset(x: 120, y: 18)

            VStack(alignment: .leading, spacing: 16) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Ficha de Campo")
                            .font(.caption.bold())
                            .foregroundColor(.black.opacity(0.55))
                            .textCase(.uppercase)
                            .tracking(1.3)

                        Text(presenter.pokemon.name.capitalized)
                            .font(DSTypography.pokemonName)
                            .foregroundColor(.black.opacity(0.86))

                        Text(String(format: "#%04d", presenter.pokemon.id))
                            .font(.headline.weight(.semibold))
                            .foregroundColor(.black.opacity(0.58))
                    }

                    Spacer()

                    VStack(alignment: .trailing, spacing: 6) {
                        Text("Estado")
                            .font(.caption.weight(.semibold))
                            .foregroundColor(.black.opacity(0.45))
                            .textCase(.uppercase)

                        Text("Registrado")
                            .font(.subheadline.bold())
                            .foregroundColor(presenter.primaryTypeColor.opacity(0.95))
                    }
                }

                ZStack {
                    Circle()
                        .stroke(Color.white.opacity(0.40), lineWidth: 16)
                        .frame(width: 220, height: 220)

                    Circle()
                        .stroke(presenter.primaryTypeColor.opacity(0.16), lineWidth: 1)
                        .frame(width: 254, height: 254)

                    if let url = presenter.currentArtworkURL {
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .scaledToFit()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(height: 210)
                        .shadow(color: Color.black.opacity(0.14), radius: 16, x: 0, y: 10)
                    } else {
                        Image(systemName: "photo")
                            .font(.system(size: 42, weight: .medium))
                            .foregroundColor(.gray)
                            .frame(height: 210)
                    }
                }
                .frame(maxWidth: .infinity)

                VStack(alignment: .leading, spacing: 12) {
                    HStack(spacing: 8) {
                        ForEach(presenter.pokemon.types, id: \.slot) { entry in
                            TypeChip(type: entry.type.name)
                        }
                    }

                    HStack(spacing: 10) {
                        DetailBadge(title: "Formas", value: presenter.formsCountLabel)
                        DetailBadge(title: "Evoluciones", value: presenter.evolutionsCountLabel)
                        if presenter.supplementalData?.shinyArtworkURL != nil {
                            DetailBadge(title: "Shiny", value: "Sí")
                        }
                    }
                }
            }
            .padding(22)
        }
        .frame(maxWidth: .infinity)
    }
}

struct DetailBadge: View {
    let title: String
    let value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.caption.weight(.semibold))
                .foregroundColor(.black.opacity(0.46))
                .textCase(.uppercase)

            Text(value)
                .font(.subheadline.bold())
                .foregroundColor(.black.opacity(0.82))
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(Color.white.opacity(0.60))
        )
    }
}

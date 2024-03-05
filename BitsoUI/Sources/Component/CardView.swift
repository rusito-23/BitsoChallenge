import SwiftUI

/// A generic component to wrap content in a card.
public struct CardView<Content: View>: View {
    private let padding: Spacing
    private let radius: Border.Radius
    private let borderWidth: Border.Width
    private let borderColor: Color
    private let content: Content

    /// Creates a new card container.
    /// - Parameter padding: The spacing to be used for the content inside the card. Defaults to `medium`.
    /// - Parameter radius: The corner radius of the card. Defaults to `medium`.
    /// - Parameter borderWidth: The width of the border of the card. Defaults to `regular`.
    /// - Parameter borderColor: The color of the border of the card. Defaults to `primary`.
    /// - Parameter content: The View to be displayed inside the container.
    public init(
        padding: Spacing = .medium,
        radius: Border.Radius = .medium,
        borderWidth: Border.Width = .regular,
        borderColor: Color = .primary,
        _ content: () -> Content
    ) {
        self.padding = padding
        self.radius = radius
        self.borderWidth = borderWidth
        self.borderColor = borderColor
        self.content = content()
    }

    public var body: some View {
        content
            .padding(padding.rawValue)
            .overlay(
                RoundedRectangle(cornerRadius: radius.rawValue)
                    .stroke(borderColor, lineWidth: borderWidth.rawValue)
            )
    }
}

// MARK: - Previews

#if DEBUG
@available(*, unavailable)
struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CardView {
                Text("Card Preview").font(.title)
            }

            CardView {
                HStack {
                    IconView(icon: .magnifyingGlass, size: .medium)
                    Text("Card Preview with Icon").font(.title)
                }
            }

            CardView {
                HStack {
                    IconView(icon: .magnifyingGlass, size: .medium)
                    VStack {
                        Text("Card Preview with Icon").font(.title)
                        Text("and a small subtitle").font(.title3)
                    }
                }
            }
        }
        .padding(Spacing.small.rawValue)
        .frame(maxWidth: .infinity)
    }
}
#endif

import SwiftUI

/// A generic component to wrap content in a card.
public struct CardContainer<Content: View>: View {

    // MARK: Properties

    private let padding: Spacing
    private let radius: Border.Radius
    private let borderWidth: Border.Width
    private let borderColor: Color
    private let content: Content

    // MARK: Initializer

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

    // MARK: Body

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
struct CardContainer_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CardContainer {
                Text("Card Preview")
                    .font(.title)
                    .frame(maxWidth: .infinity)
            }

            CardContainer {
                HStack {
                    IconView(
                        icon: .magnifyingGlass,
                        size: .medium
                    )

                    Text("Card Preview with Icon")
                        .font(.title)
                }
                .frame(maxWidth: .infinity)
            }

            CardContainer {
                HStack {
                    IconView(
                        icon: .magnifyingGlass,
                        size: .medium
                    )

                    VStack {
                        Text("Card Preview with Icon")
                            .font(.title)

                        Text("and a small subtitle")
                            .font(.title3)
                    }
                }
                .frame(maxWidth: .infinity)
            }
        }
        .padding(Spacing.small.rawValue)
    }
}
#endif

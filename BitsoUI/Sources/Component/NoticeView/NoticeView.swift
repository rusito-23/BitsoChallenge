import SwiftUI

/// A view that displays a generic notice.
/// Includes a title, an optional icon and a message.
public struct NoticeView: View {

    // MARK: Properties

    private let icon: Icon
    private let title: String
    private let subtitle: String
    private let iconSize: IconSize = .medium

    // MARK: Initializer

    public init(icon: Icon, title: String, subtitle: String) {
        self.icon = icon
        self.title = title
        self.subtitle = subtitle
    }

    // MARK: Body

    public var body: some View {
        VStack(alignment: .center, spacing: Spacing.medium.rawValue) {
            Text(title)
                .font(.title)

            Image(systemName: icon.rawValue)
                .resizable()
                .frame(width: iconSize.rawValue, height: iconSize.rawValue)

            Text(subtitle)
                .font(.title2)
        }
    }
}

#if DEBUG
@available(*, unavailable)
struct NoticeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NoticeView(
                icon: .magnifyingGlass,
                title: "No results",
                subtitle: "We got not results!"
            )
            .previewDisplayName("No results")

            NoticeView(
                icon: .error,
                title: "Error",
                subtitle: "Something went wrong!"
            )
            .previewDisplayName("Error")
        }
    }
}
#endif

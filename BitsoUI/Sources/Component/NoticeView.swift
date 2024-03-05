import SwiftUI

/// Displays a generic notice that includes a title, an icon and a message.
public struct NoticeView: View {
    private let icon: Icon
    private let title: String
    private let message: String
    private let iconSize: IconSize = .medium

    /// Create a notice view.
    /// - Parameter icon: The icon to be displayed at the center.
    /// - Parameter title: The title of the notice.
    /// - Parameter message: The notice message.
    public init(icon: Icon, title: String, message: String) {
        self.icon = icon
        self.title = title
        self.message = message
    }

    public var body: some View {
        VStack(alignment: .center, spacing: Spacing.medium.rawValue) {
            Text(title)
                .font(.title)

            Image(systemName: icon.rawValue)
                .resizable()
                .frame(width: iconSize.rawValue, height: iconSize.rawValue)

            Text(message)
                .font(.title2)
        }
    }
}

// MARK: - Previews

#if DEBUG
@available(*, unavailable)
struct NoticeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NoticeView(
                icon: .magnifyingGlass,
                title: "No results",
                message: "We got not results!"
            )
            .previewDisplayName("No results")

            NoticeView(
                icon: .error,
                title: "Error",
                message: "Something went wrong!"
            )
            .previewDisplayName("Error")
        }
    }
}
#endif

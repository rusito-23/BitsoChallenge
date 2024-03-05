import SwiftUI

/// Displays a generic notice that includes a title, an icon and an optional message.
public struct NoticeView: View {
    private let viewModel: NoticeViewModel

    /// Create a notice view.
    /// - Parameter viewModel: The ``NoticeViewModel`` to model the view.
    public init(viewModel: NoticeViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        VStack(alignment: .center, spacing: Spacing.medium.rawValue) {
            Text(viewModel.title)
                .font(.title)

            Image(systemName: viewModel.icon.rawValue)
                .resizable()
                .frame(width: viewModel.iconSize.rawValue, height: viewModel.iconSize.rawValue)

            Text(viewModel.message)
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
            NoticeView(viewModel: .init(
                icon: .magnifyingGlass,
                title: "No results",
                message: "We got not results!"
            ))
            .previewDisplayName("No results")

            NoticeView(viewModel: .init(
                icon: .error,
                title: "Error",
                message: "Something went wrong!"
            ))
            .previewDisplayName("Error")
        }
    }
}
#endif

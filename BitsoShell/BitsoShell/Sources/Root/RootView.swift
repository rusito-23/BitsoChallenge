import BitsoBookModule
import BitsoKit
import BitsoUI
import SwiftUI

struct RootView: View {
    @EnvironmentObject private var router: Router

    var body: some View {
        VStack(alignment: .center, spacing: Spacing.small.rawValue) {
            title
            Spacer()
            button
        }
        .padding(Spacing.medium.rawValue)
    }

    private var title: some View {
        Text(Content.title.localize())
            .font(.largeTitle)
    }

    private var button: some View {
        Button {
            router.navigate(to: BookDestination.bookList)
        } label: {
            Text(Content.booksButtonTitle.localize())
                .font(.body)
        }
        .tint(.accentColor)
        .controlSize(.large)
        .buttonStyle(.bordered)
    }
}

// MARK: - Content

private extension RootView {
    enum Content: String, LocalizableContent {
        case title = "WELCOME_TITLE"
        case booksButtonTitle = "BOOKS_BUTTON_TITLE"
    }
}

// MARK: - Previews

#if DEBUG

@available(*, unavailable)
struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}

#endif

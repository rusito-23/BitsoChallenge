import BitsoNav
import BitsoKit
import BitsoUI
import SwiftUI

struct RootView: View {
    @EnvironmentObject private var router: Router
        private let viewModel = RootViewModel()

    var body: some View {
        VStack(spacing: Spacing.small.rawValue) {
            title
            Spacer()
            button
            Spacer()
        }
        .padding(Spacing.medium.rawValue)
    }

    private var title: some View {
        Text(viewModel.title)
            .font(.largeTitle)
    }

    private var button: some View {
        Button {
            // router.navigate(to: Text())
        } label: {
            Text(viewModel.booksButtonTitle)
                .font(.body)
        }
        .tint(.accentColor)
        .controlSize(.large)
        .buttonStyle(.bordered)
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

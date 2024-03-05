import BitsoUI
import SwiftUI

struct BookDetailsView<ViewModel: BookDetailsViewModel>: View {

    // MARK: Properties

    @StateObject private var viewModel: ViewModel

    // MARK: Initializer

    init(viewModel: ViewModel) {
        _viewModel = .init(wrappedValue: viewModel)
    }

    // MARK: Body

    var body: some View {
        ZStack {
            switch viewModel.state {
            case .loading:
                loadingView
            case let .failed(error: error):
                errorView(error)
            case let .loaded(details: bookDetails):
                bookDetailsView(bookDetails)
            }
        }
        .navigationTitle(viewModel.title ?? "")
        .onAppear {
            viewModel.load()
        }
    }

    // MARK: Private Views

    private var loadingView: some View {
        Text("Loading")
    }

    private func errorView(_ error: BookServiceError) -> some View {
        NoticeView(
            icon: .error,
            title: "",
            subtitle: ""
            // title: Content.noticeTitle.localize(bundle: .module),
            // subtitle: Content.emptyResultsMessage.localize(bundle: .module)
        )
    }

    private func bookDetailsView(_ details: BookDetails) -> some View {
        Text(details.name)
    }
}

// MARK: - Previews

#if DEBUG
struct BookDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Text("World!")
        }
    }
}
#endif

import BitsoUI
import BitsoKit
import SwiftUI

struct BookListView<ViewModel: BookListViewModel>: View {

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
            case .empty:
                emptyView
            case let .failed(error: error):
                errorView(error)
            case let .loaded(books: books):
                booksListView(books)
            }
        }
        .onAppear {
            viewModel.loadBooks()
        }
    }

    // MARK: Private Views

    private var loadingView: some View {
        Text("Loading")
    }

    private var emptyView: some View {
        NoticeView(
            icon: .magnifyingGlass,
            title: Content.noticeTitle.localize(bundle: .module),
            subtitle: Content.emptyResultsMessage.localize(bundle: .module)
        )
    }

    private func errorView(_ error: BookServiceError) -> some View {
        NoticeView(
            icon: .error,
            title: Content.noticeTitle.localize(bundle: .module),
            subtitle: Content.emptyResultsMessage.localize(bundle: .module)
        )
    }

    private func booksListView(_ books: [BookListCardViewModel]) -> some View {
        List(books, id: \.id) { book in
            BookListCard(viewModel: book)
                .listRowInsets(EdgeInsets(spacing: .small))
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
        }
        .scrollContentBackground(.hidden)
        .refreshable { viewModel.loadBooks() }
        .padding(Spacing.small.rawValue)
    }
}

// MARK: - Content

private extension BookListView {
    enum Content: String, LocalizableContent {
        case noticeTitle = "OOPS"
        case emptyResultsMessage = "BOOK_LIST_EMPTY_RESULT_MESSAGE"
        case errorMessage = "BOOK_LIST_ERROR_MESSAGE"
    }
}

// MARK: - Previews

#if DEBUG
@available(*, unavailable)
struct BookListView_Previews: PreviewProvider {
    final class ViewModelMock: BookListViewModel {
        var state: BookListState
        init(state: BookListState) { self.state = state }
        func loadBooks() -> Task<Void, Never> { Task {} }
    }

    static var previews: some View {
        Group {
            BookListView(viewModel: ViewModelMock(state: .loading))
                .previewDisplayName("Loading")

            BookListView(viewModel: ViewModelMock(state: .empty))
                .previewDisplayName("Empty")

            BookListView(viewModel: ViewModelMock(state: .loaded(books: [
                BookListCardViewModel(
                    name: "Book 1",
                    maximumValue: "$ 150",
                    minimumValue: "$ 100",
                    maximumPrice: "$200"
                ),
                BookListCardViewModel(
                    name: "Book 2",
                    maximumValue: "$ 180",
                    minimumValue: "$ 120",
                    maximumPrice: "$230"
                ),
            ])))
            .previewDisplayName("Loaded")

            BookListView(viewModel: ViewModelMock(state: .failed(error: .network)))
                .previewDisplayName("Failed")
        }
    }
}
#endif

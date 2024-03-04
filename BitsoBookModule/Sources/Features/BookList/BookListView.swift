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
            case .initial, .loading:
                shimmerView
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

    private var shimmerView: some View {
        Text("Loading")
    }

    private var emptyView: some View {
        Text("Empty")
    }

    private func errorView(_ error: BookServiceError) -> some View {
        Text("Error")
    }

    private func booksListView(_ books: [Book]) -> some View {
        List(books, id: \.book) { book in
            Text(book.book)
        }
        .refreshable {
            viewModel.loadBooks()
        }
    }
}

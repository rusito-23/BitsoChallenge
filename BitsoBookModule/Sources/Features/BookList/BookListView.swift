import BitsoUI
import BitsoKit
import SwiftUI

struct BookListView<ViewModel: BookListViewModeling>: View {
    @StateObject private var viewModel: ViewModel

    init(viewModel: ViewModel) {
        _viewModel = .init(wrappedValue: viewModel)
    }

    var body: some View {
        ZStack {
            switch viewModel.state {
            case .loading:
                ProgressView()

            case let .failed(notice: noticeViewModel):
                NoticeView(viewModel: noticeViewModel)

            case let .loaded(books: books):
                booksListView(books)
            }
        }
        .onAppear {
            viewModel.loadBooks()
        }
    }
}

// MARK: - Private Views

extension BookListView {
    func booksListView(_ books: [BookCardViewModel]) -> some View {
        List(books, id: \.id) { book in
            BookCardView(viewModel: book)
                .listRowInsets(EdgeInsets(spacing: .small))
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
        }
        .scrollContentBackground(.hidden)
        .refreshable { viewModel.loadBooks() }
        .padding(Spacing.small.rawValue)
    }
}

// MARK: - Previews

#if DEBUG
@available(*, unavailable)
struct BookListView_Previews: PreviewProvider {
    final class ViewModelMock: BookListViewModeling {
        var state: BookListState
        init(state: BookListState) { self.state = state }
        func loadBooks() -> Task<Void, Never> { Task {} }
    }

    static var previews: some View {
        Group {
            BookListView(viewModel: ViewModelMock(state: .loading))
                .previewDisplayName("Loading")

            BookListView(viewModel: ViewModelMock(state: .loaded(books: [
                BookCardViewModel(
                    name: "Book 1",
                    maximumValue: "$ 150",
                    minimumValue: "$ 100",
                    maximumPrice: "$200"
                ),
                BookCardViewModel(
                    name: "Book 2",
                    maximumValue: "$ 180",
                    minimumValue: "$ 120",
                    maximumPrice: "$230"
                ),
            ])))
            .previewDisplayName("Loaded")

            BookListView(viewModel: ViewModelMock(state: .failed(notice: NoticeViewModel(
                icon: .error,
                title: "Oops!",
                message: "Something went wrong."
            ))))
            .previewDisplayName("Failed")
        }
    }
}
#endif

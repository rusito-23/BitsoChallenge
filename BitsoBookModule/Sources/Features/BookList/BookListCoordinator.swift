import BitsoNet
import SwiftUI

/// The coordinator of the book list screen.
@MainActor
struct BookListCoordinator: View {
    private let environment: APIEnvironment
    private let viewModel: BookListViewModel

    init(environment: APIEnvironment) {
        let service = LiveBookService(environment: environment)
        self.environment = environment
        self.viewModel = BookListViewModel(service: service)
    }

    var body: some View {
        BookListView(viewModel: viewModel)
            .navigationDestination(for: Destination.self) { destination in
                coordinator(for: destination)
            }
    }
}

// MARK: - Navigation

extension BookListCoordinator {
    /// The internal destinations of the book list coordinator.
    enum Destination: Hashable {
        /// Navigate to the detail page of a book.
        /// - Parameter id: The id of the book.
        case bookDetails(id: String)
    }

    @ViewBuilder
    @MainActor
    func coordinator(for destination: Destination) -> some View {
        switch destination {
        case let .bookDetails(id: bookID):
            BookDetailsCoordinator(bookID: bookID, environment: environment)
        }
    }
}

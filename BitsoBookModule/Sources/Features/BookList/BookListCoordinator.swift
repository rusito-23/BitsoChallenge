import BitsoNet
import SwiftUI

/// The coordinator of the book list screen.
@MainActor
struct BookListCoordinator: View {
    private let viewModel: BookListViewModel

    init(environment: APIEnvironment) {
        let service = LiveBookService(environment: environment)
        self.viewModel = BookListViewModel(service: service)
    }

    var body: some View {
        BookListView(viewModel: viewModel)
    }
}

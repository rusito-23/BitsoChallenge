import BitsoNet
import SwiftUI

/// The coordinator of the book list screen.
@MainActor
struct BookListCoordinator: View {
    private let viewModel: LiveBookListViewModel

    init(environment: APIEnvironment) {
        let service = LiveBookService(environment: environment)
        self.viewModel = LiveBookListViewModel(service: service)
    }

    var body: some View {
        BookListView(viewModel: viewModel)
    }
}

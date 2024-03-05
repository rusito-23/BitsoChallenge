import BitsoNet
import SwiftUI

/// The coordinator of the book details screen.
@MainActor
struct BookDetailsCoordinator: View {
    private let viewModel: LiveBookDetailsViewModel

    init(bookID: String, environment: APIEnvironment) {
        let service = LiveBookService(environment: environment)
        self.viewModel = LiveBookDetailsViewModel(bookID: bookID, service: service)
    }

    var body: some View {
        BookDetailsView(viewModel: viewModel)
    }
}

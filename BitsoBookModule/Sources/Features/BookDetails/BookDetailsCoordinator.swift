import BitsoNet
import SwiftUI

/// The coordinator of the book details screen.
@MainActor
struct BookDetailsCoordinator: View {
    private let viewModel: BookDetailsViewModel

    init(bookID: String, environment: APIEnvironment) {
        let service = LiveBookService(environment: environment)
        self.viewModel = BookDetailsViewModel(bookID: bookID, service: service)
    }

    var body: some View {
        BookDetailsView(viewModel: viewModel)
    }
}

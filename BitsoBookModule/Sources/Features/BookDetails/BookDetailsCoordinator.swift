import BitsoNet
import SwiftUI

@MainActor
struct BookDetailsCoordinator: View {

    // MARK: Properties

    private let viewModel: LiveBookDetailsViewModel

    // MARK: Initializer

    init(bookID: String, domain: DomainProvider) {
        let service = LiveBookService(domain: domain)
        self.viewModel = LiveBookDetailsViewModel(bookID: bookID, service: service)
    }

    // MARK: Body

    var body: some View {
        BookDetailsView(viewModel: viewModel)
    }
}

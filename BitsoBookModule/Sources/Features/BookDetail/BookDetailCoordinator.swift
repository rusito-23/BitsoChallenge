import BitsoNet
import SwiftUI

@MainActor
struct BookDetailCoordinator: View {

    // MARK: Properties

    private let viewModel: LiveBookDetailViewModel

    // MARK: Initializer

    init(bookID: String, domain: DomainProvider) {
        let service = LiveBookService(domain: domain)
        self.viewModel = LiveBookDetailViewModel(bookID: bookID, service: service)
    }

    // MARK: Body

    var body: some View {
        BookDetailView(viewModel: viewModel)
    }
}

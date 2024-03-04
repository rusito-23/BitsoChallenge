import BitsoNet
import SwiftUI

@MainActor
struct BookListCoordinator: View {

    // MARK: Properties

    private let viewModel: LiveBookListViewModel

    // MARK: Initializer

    init(domain: DomainProvider) {
        let service = LiveBookService(domain: domain)
        self.viewModel = LiveBookListViewModel(service: service)
    }

    // MARK: Body

    var body: some View {
        BookListView(viewModel: viewModel)
    }
}

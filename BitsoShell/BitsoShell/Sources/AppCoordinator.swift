import BitsoBooks
import BitsoKit
import BitsoUI
import SwiftUI

struct AppCoordinator: View {

    // MARK: Observed Properties

    @ObservedObject var router = Router()

    // MARK: Modules

    private let booksModule: any BooksModule

    // MARK: Initializer

    init(booksModule: any BooksModule = LiveBooksModule()) {
        self.booksModule = booksModule
    }

    // MARK: Body

    var body: some View {
        NavigationStack(path: $router.path) {
            RootView()
                .navigationDestination(
                    for: BooksDestination.self,
                    destination: booksModule.navigation
                )
        }
        .environmentObject(router)
    }
}

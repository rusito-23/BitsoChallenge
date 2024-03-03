import BitsoBookModule
import BitsoKit
import BitsoUI
import SwiftUI

struct AppCoordinator: View {

    // MARK: Observed Properties

    @ObservedObject var router = Router()

    // MARK: Modules

    private let booksModule: any BookModule

    // MARK: Initializer

    init(booksModule: any BookModule = LiveBookModule()) {
        self.booksModule = booksModule
    }

    // MARK: Body

    var body: some View {
        NavigationStack(path: $router.path) {
            RootView()
                .navigationDestination(
                    for: BookDestination.self,
                    destination: booksModule.navigation
                )
        }
        .environmentObject(router)
    }
}

import BitsoBookModule
import BitsoKit
import BitsoUI
import BitsoNet
import SwiftUI

/// The coordinator for the whole application.
///
/// Will hols all the available modules, the main navigation stack, and the navigation router.
/// Will also determine the first navigation view.
struct AppCoordinator: View {
    @ObservedObject var router = Router()

    // MARK: Modules

    private let bookModule: any BookModule

    // MARK: Initializers

    init(bookModule: any BookModule) {
        self.bookModule = bookModule
    }

    init(environment: APIEnvironment) {
        self.bookModule = LiveBookModule(environment: environment)
    }

    // MARK: Body

    var body: some View {
        NavigationStack(path: $router.path) {
            bookModule.navigation(to: .bookList)
        }
        .environmentObject(router)
    }
}

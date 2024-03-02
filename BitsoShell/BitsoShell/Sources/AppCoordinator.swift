import BitsoBooks
import BitsoKit
import BitsoUI
import SwiftUI

struct AppCoordinator: View {
    let id = UUID()
    @ObservedObject var router = Router()

    var body: some View {
        NavigationStack(path: $router.path) {
            RootView()
                .navigationDestination(for: BooksDestinations.self, destination: navigate)
        }
        .environmentObject(router)
    }

    @ViewBuilder
    func navigate(to destination: BooksDestinations) -> some View {
        switch destination {
        case .booksList: BooksListView()
        }
    }
}

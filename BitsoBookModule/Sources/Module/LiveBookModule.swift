import BitsoKit
import BitsoNet
import SwiftUI
import Foundation

/// The ``BookModule`` live implementation.
public struct LiveBookModule: BookModule {

    // MARK: Properties

    private let domain: Domain

    // MARK: Public Initializer

    /// Create a books module.
    public init(domain: any Domain) {
        self.domain = domain
    }

    // MARK: Navigation

    /// Creates the view from the given destination, transformed as `AnyView`.
    /// - Parameter destination: The ``BookDestination`` to be triggered.
    /// -  Returns: The view to be navigated to.
    public func navigation(to destination: BookDestination) -> AnyView {
        AnyView(view(for: destination))
    }

    // MARK: Private Methods

    /// Creates the view from the given destination.
    /// - Parameter destination: The ``BookDestination`` to be triggered.
    /// -  Returns: The view to be navigated to.
    @ViewBuilder private func view(for destination: BookDestination) -> some View {
        switch destination {
        case .bookList: BookListView()
        }
    }
}

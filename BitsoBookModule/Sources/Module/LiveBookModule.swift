import BitsoKit
import BitsoNet
import SwiftUI
import Foundation

/// The ``BookModule`` live implementation.
public struct LiveBookModule: BookModule {

    // MARK: Properties

    private let dependencies: Dependencies

    // MARK: Public Initializer

    /// Create a books module.
    /// - Parameter dependencies: The dependencies needed to create a ``LiveBookModule``.
    public init(dependencies: Dependencies) {
        self.dependencies = dependencies
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

// MARK: - Dependencies

public extension LiveBookModule {
    /// Describes the dependencies needed to create a ``LiveBookModule``.
    struct Dependencies {
        private let domain: DomainProvider

        public init(domain: DomainProvider) {
            self.domain = domain
        }
    }
}

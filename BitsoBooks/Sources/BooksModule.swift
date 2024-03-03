import BitsoKit
import SwiftUI
import Foundation

// MARK: Protocol

public protocol BooksModule: Module where Destination == BooksDestination {}

// MARK: Implementation

/// The live implementation of the books module protocol.
public struct LiveBooksModule: BooksModule {

    // MARK: Public Initializer

    /// Create a books module.
    public init() {}

    // MARK: Navigation

    /// Navigate to a given destination.
    public func navigation(to destination: BooksDestination) -> AnyView {
        AnyView(view(for: destination))
    }

    // MARK: Private Methods

    /// Creates the view from the given destination.
    @ViewBuilder private func view(for destination: BooksDestination) -> some View {
        switch destination {
        case .booksList: BooksListView()
        }
    }
}

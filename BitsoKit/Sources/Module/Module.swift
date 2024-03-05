import SwiftUI

/// Describes the requirements for module exposure classes.
/// These will serve as entry points to navigate to a module.
public protocol Module {

    // MARK: Types

    /// The destination type associated with this module.
    associatedtype Destination: Hashable

    // MARK: Methods

    /// Provides the view associated with a given destination.
    /// - Parameter destination: The nav destination.
    /// - Returns: The view that needs to be navigated to.
    func navigation(to destination: Destination) -> AnyView
}

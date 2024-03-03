import SwiftUI

/// Describes the requirements for module exposure classes.
/// Module will expose publicly some functionality that needs to be triggered externally, such as:
/// - navigation
/// - app lifecycle
/// - universal link handling
public protocol Module {

    // MARK: Types

    /// The destination type associated with this module.
    associatedtype Destination

    // MARK: Navigation Methods

    /// Provides the view associated with a given destination.
    /// - Parameter destination: The nav destination.
    /// - Returns: The view that needs to be navigated to.
    func navigation(to destination: Destination) -> AnyView
}

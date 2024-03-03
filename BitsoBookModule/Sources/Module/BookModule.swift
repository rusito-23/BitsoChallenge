import BitsoKit
import Foundation

/// Describes the required interface for the book module entry.
/// The book module should conform to the generic module,
/// specifying that it can only handle ``BookDestination``,
public protocol BookModule: Module where Destination == BookDestination {}

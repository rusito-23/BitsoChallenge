import Foundation

/// Holds the different app configurations:
/// - Environment: Determines what environment we will be using across the app. 
struct Configuration {
    let environment: Environment

    init(environment: Environment) {
        self.environment = environment
    }
}

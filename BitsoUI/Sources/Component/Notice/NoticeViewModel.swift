import Foundation

public struct NoticeViewModel {
    let icon: Icon
    let title: String
    let message: String
    let iconSize: IconSize = .medium

    /// Create a notice view model.
    /// - Parameter icon: The icon to be displayed at the center.
    /// - Parameter title: The title of the notice.
    /// - Parameter message: The notice message.
    public init(icon: Icon, title: String, message: String) {
        self.icon = icon
        self.title = title
        self.message = message
    }
}

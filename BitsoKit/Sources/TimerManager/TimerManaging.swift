import Foundation

/// Wrapper around scheduled timers, provides a simple interface to initiate a timer and takes care of the rest.
public protocol TimerManaging {
    /// Schedules the timer for a given task.
    /// - Parameter interval: The time interval to trigger the timer in seconds.
    /// - Parameter repeats: Whether the timer should repeat or is a one-time.
    /// - Parameter task: The code block that launches the task to be called when the timer triggers.
    func schedule(
        interval: TimeInterval,
        repeats: Bool,
        task: @escaping () -> Task<Void, Never>?
    )
}

import Foundation

public final class TimerManager<T: Timer>: TimerManaging {
    private var timer: Timer?

    public init() {}

    deinit {
        timer?.invalidate()
    }

    public func schedule(
        interval: TimeInterval,
        repeats: Bool,
        task: @escaping () -> Task<Void, Never>?
    ) {
        timer = T.scheduledTimer(withTimeInterval: interval, repeats: repeats) { _ in
            // We don't need to start the task manually.
            _ = task()
        }
    }
}

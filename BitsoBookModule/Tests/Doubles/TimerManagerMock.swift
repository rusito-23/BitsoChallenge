import BitsoKit
import Foundation

final class TimerManagerMock: TimerManaging {
    private(set) var interval: TimeInterval?
    private(set) var repeats: Bool?
    private(set) var task: (() -> Task<Void, Never>?)?

    func schedule(
        interval: TimeInterval,
        repeats: Bool,
        task: @escaping () -> Task<Void, Never>?
    ) {
        self.interval = interval
        self.repeats = repeats
        self.task = task
    }

    func trigger() -> Task<Void, Never>? {
        task?()
    }
}

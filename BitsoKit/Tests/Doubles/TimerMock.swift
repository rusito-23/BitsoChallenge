import Foundation

/// A mock version of Apple's Timer.
/// Instead of actually scheduling the timer, we return an empty Timer and save the block to be able to trigger it.
final class TimerMock: Timer {
    private(set) static var currentTimerBlock: ((Timer) -> Void)?
    private(set) static var currentInvalidateBlock: (() -> Void)?

    static func onInvalidate(_ block: @escaping () -> Void) {
        currentInvalidateBlock = block
    }

    override class func scheduledTimer(
        withTimeInterval interval: TimeInterval,
        repeats: Bool,
        block: @escaping (Timer) -> Void
    ) -> Timer {
        currentTimerBlock = block
        return TimerMock()
    }

    /// To allow testing if the timer invalidates, we need to use a block.
    /// If we assert against a boolean value instead, we would be keeping a static state, which is hard to cleanup in other tests.
    override func invalidate() {
        Self.currentInvalidateBlock?()
        Self.currentInvalidateBlock = nil
    }
}

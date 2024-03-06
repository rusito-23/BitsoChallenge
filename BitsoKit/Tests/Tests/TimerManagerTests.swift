import XCTest
@testable import BitsoKit

final class TimerManagerTests: XCTestCase {
    func test_schedule_shouldCreateTimer() {
        // GIVEN
        let manager = TimerManager<TimerMock>()

        let expectation = self.expectation(description: "Timer Fired")
        manager.schedule(interval: 1, repeats: false, task: {
            Task {
                expectation.fulfill()
            }
        })

        // WHEN
        TimerMock.currentTimerBlock?(Timer())

        // THEN
        waitForExpectations(timeout: 2)
    }

    func test_deinit_shouldInvalidateTimer() {
        // GIVEN
        var manager: TimerManager<TimerMock>? = TimerManager()

        let expectation = self.expectation(description: "Timer Invalidated")
        TimerMock.onInvalidate {
            expectation.fulfill()
        }

        // WHEN
        manager?.schedule(interval: 1, repeats: false, task: { Task {} })
        manager = nil

        // THEN
        waitForExpectations(timeout: 2)
    }
}

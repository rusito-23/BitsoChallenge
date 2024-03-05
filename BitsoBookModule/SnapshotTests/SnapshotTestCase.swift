import SnapshotTesting
import SwiftUI
import XCTest

/// Determines the base behavior for snapshot tests.
class SnapshotTestCase: XCTestCase {
    private(set) var shouldRecord: Bool = false

    override func setUp() {
        super.setUp()
        shouldRecord = ProcessInfo
            .processInfo
            .environment["RECORD_SNAPSHOTS"]
            .flatMap { Bool($0) } ?? false
    }
}

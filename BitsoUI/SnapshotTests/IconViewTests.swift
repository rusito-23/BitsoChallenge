import BitsoUI
import SnapshotTesting
import SwiftUI
import XCTest

final class IconViewTests: SnapshotTestCase {
    func test_magnifyingGlass() {
        let view = VStack(spacing: Spacing.medium.rawValue) {
            IconView(icon: .magnifyingGlass, size: .small)
            IconView(icon: .magnifyingGlass, size: .medium)
            IconView(icon: .magnifyingGlass, size: .large)
        }.fixedSize(
            horizontal: true,
            vertical: true
        )

        assertSnapshot(of: view, as: .image, record: shouldRecord)
    }

    func test_error() {
        let view = VStack(spacing: Spacing.medium.rawValue) {
            IconView(icon: .error, size: .small)
            IconView(icon: .error, size: .medium)
            IconView(icon: .error, size: .large)
        }.fixedSize(
            horizontal: true,
            vertical: true
        )

        assertSnapshot(of: view, as: .image, record: shouldRecord)
    }
}

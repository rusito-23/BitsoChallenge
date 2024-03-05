import BitsoUI
import SnapshotTesting
import SwiftUI
import XCTest

final class CardViewTests: SnapshotTestCase {
    func test_cardView_withDefaults() {
        let view = CardView {
            Text("Card view content")
        }.fixedSize(
            horizontal: true,
            vertical: true
        )

        assertSnapshot(of: view, as: .image, record: shouldRecord)
    }

    func test_cardView_withColoredBorder() {
        let view = CardView(borderColor: .blue) {
            Text("Card view content")
        }.fixedSize(
            horizontal: true,
            vertical: true
        )

        assertSnapshot(of: view, as: .image, record: shouldRecord)
    }

    func test_cardView_withBoldBorder() {
        let view = CardView(borderWidth: .bold) {
            Text("Card view content")
        }.fixedSize(
            horizontal: true,
            vertical: true
        )

        assertSnapshot(of: view, as: .image, record: shouldRecord)
    }

    func test_cardView_withLargeRadius() {
        let view = CardView(radius: .large) {
            Text("Card view content")
        }.fixedSize(
            horizontal: true,
            vertical: true
        )

        assertSnapshot(of: view, as: .image, record: shouldRecord)
    }

    func test_cardView_withSmallRadius() {
        let view = CardView(radius: .small) {
            Text("Card view content")
        }.fixedSize(
            horizontal: true,
            vertical: true
        )

        assertSnapshot(of: view, as: .image, record: shouldRecord)
    }
}

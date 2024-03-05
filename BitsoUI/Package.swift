// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "BitsoUI",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "BitsoUI",
            targets: ["BitsoUI"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-snapshot-testing", from: "1.12.0"),
    ],
    targets: [
        .target(
            name: "BitsoUI",
            dependencies: [],
            path: "Sources"
        ),
        .testTarget(
            name: "BitsoUITests",
            dependencies: ["BitsoUI"],
            path: "Tests"
        ),
        .testTarget(
            name: "BitsoUISnapshotTests",
            dependencies: [
                "BitsoUI",
                .product(name: "SnapshotTesting", package: "swift-snapshot-testing"),
            ],
            path: "SnapshotTests"
        ),
    ]
)

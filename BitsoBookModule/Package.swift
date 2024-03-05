// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "BitsoBookModule",
    defaultLocalization: "en",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "BitsoBookModule",
            targets: ["BitsoBookModule"]
        ),
    ],
    dependencies: [
        .package(path: "../../BitsoKit"),
        .package(path: "../../BitsoUI"),
        .package(path: "../../BitsoNet"),
        .package(url: "https://github.com/pointfreeco/swift-snapshot-testing", from: "1.12.0"),
    ],
    targets: [
        .target(
            name: "BitsoBookModule",
            dependencies: [
                "BitsoKit",
                "BitsoUI",
                "BitsoNet",
            ],
            path: "Sources",
            resources: [.process("Resources")]
        ),
        .testTarget(
            name: "BitsoBookModuleTests",
            dependencies: [
                "BitsoBookModule",
            ],
            path: "Tests",
            resources: [.process("Resources")]
        ),
        .testTarget(
            name: "BitsoBookModuleSnapshotTests",
            dependencies: [
                "BitsoBookModule",
                .product(name: "SnapshotTesting", package: "swift-snapshot-testing"),
            ],
            path: "SnapshotTests"
        ),
    ]
)

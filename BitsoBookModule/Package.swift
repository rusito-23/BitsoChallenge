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
    ]
)

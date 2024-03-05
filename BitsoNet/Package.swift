// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "BitsoNet",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "BitsoNet",
            targets: ["BitsoNet"]
        ),
    ],
    dependencies: [
        .package(path: "../BitsoKit"),
    ],
    targets: [
        .target(
            name: "BitsoNet",
            dependencies: ["BitsoKit"],
            path: "Sources"
        ),
        .testTarget(
            name: "BitsoNetTests",
            dependencies: ["BitsoNet"],
            path: "Tests",
            resources: [.process("Resources")]
        ),
    ]
)

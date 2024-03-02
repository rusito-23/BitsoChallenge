// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "BitsoTestKit",
    platforms: [
        .iOS(.v16),
    ],
    products: [
        .library(
            name: "BitsoTestKit",
            targets: ["BitsoTestKit"]),
    ],
    targets: [
        .target(
            name: "BitsoTestKit",
            dependencies: [],
            path: "Sources"),
    ]
)

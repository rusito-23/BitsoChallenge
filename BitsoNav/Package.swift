// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "BitsoNav",
    platforms: [
        .iOS(.v16),
    ],
    products: [
        .library(
            name: "BitsoNav",
            targets: ["BitsoNav"]),
    ],
    targets: [
        .target(
            name: "BitsoNav",
            dependencies: [],
            path: "Sources"),
    ]
)

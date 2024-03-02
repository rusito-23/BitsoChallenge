// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "BitsoUI",
    platforms: [
        .iOS(.v16),
    ],
    products: [
        .library(
            name: "BitsoUI",
            targets: ["BitsoUI"]),
    ],
    targets: [
        .target(
            name: "BitsoUI",
            dependencies: [],
            path: "Sources"),
        .testTarget(
            name: "BitsoUITests",
            dependencies: ["BitsoUI"],
            path: "Tests"),
    ]
)

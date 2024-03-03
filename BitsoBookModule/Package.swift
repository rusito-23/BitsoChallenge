// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "BitsoBookModule",
    platforms: [
        .iOS(.v16),
    ],
    products: [
        .library(
            name: "BitsoBookModule",
            targets: ["BitsoBookModule"]),
    ],
    dependencies: [
        .package(path: "../../BitsoKit"),
        .package(path: "../../BitsoUI"),
        .package(path: "../../BitsoTestKit"),
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
            path: "Sources"),
        .testTarget(
            name: "BitsoBookModuleTests",
            dependencies: [
                "BitsoBookModule",
                "BitsoTestKit",
            ],
            path: "Tests"),
    ]
)

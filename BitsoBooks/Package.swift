// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "BitsoBooks",
    platforms: [
        .iOS(.v16),
    ],
    products: [
        .library(
            name: "BitsoBooks",
            targets: ["BitsoBooks"]),
    ],
    dependencies: [
        .package(path: "../../BitsoKit"),
        .package(path: "../../BitsoUI"),
        .package(path: "../../BitsoTestKit"),
        .package(path: "../../BitsoNet"),
    ],
    targets: [
        .target(
            name: "BitsoBooks",
            dependencies: [
                "BitsoKit",
                "BitsoUI",
                "BitsoNet",
            ],
            path: "Sources"),
        .testTarget(
            name: "BitsoBooksTests",
            dependencies: [
                "BitsoBooks",
                "BitsoTestKit",
            ],
            path: "Tests"),
    ]
)

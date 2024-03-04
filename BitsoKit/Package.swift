// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "BitsoKit",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "BitsoKit",
            targets: ["BitsoKit"]
        ),
    ],
    targets: [
        .target(
            name: "BitsoKit",
            dependencies: [],
            path: "Sources"
        ),
        .testTarget(
            name: "BitsoKitTests",
            dependencies: ["BitsoKit"],
            path: "Tests"
        ),
    ]
)

// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DevCodePurgeKit",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .library(
            name: "DevCodePurgeKit",
            targets: ["DevCodePurgeKit"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/nikolainobadi/NnTestKit", from: "1.1.0")
    ],
    targets: [
        .target(
            name: "DevCodePurgeKit"
        ),
        .testTarget(
            name: "DevCodePurgeKitTests",
            dependencies: [
                "DevCodePurgeKit",
                .product(name: "NnTestHelpers", package: "NnTestKit")
            ]
        )
    ]
)

// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CodePurgeKit",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .library(
            name: "CodePurgeKit",
            targets: ["CodePurgeKit"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/nikolainobadi/NnTestKit", from: "1.1.0")
    ],
    targets: [
        .target(
            name: "CodePurgeKit"
        ),
        .testTarget(
            name: "CodePurgeKitTests",
            dependencies: [
                "CodePurgeKit",
                .product(name: "NnTestHelpers", package: "NnTestKit")
            ]
        )
    ]
)

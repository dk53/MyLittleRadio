// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AudioPlayerFeature",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "AudioPlayerFeature",
            targets: ["AudioPlayerFeature"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "1.15.1"),
        .package(name: "Core", path: "../Core")
    ],
    targets: [
        .target(
            name: "AudioPlayerFeature",
            dependencies: [
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
            ]),
        .testTarget(
            name: "AudioPlayerFeatureTests",
            dependencies: ["AudioPlayerFeature", "Core"]
        )
    ]
)

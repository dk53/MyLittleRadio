// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "StationsFeature",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "StationsFeature",
            targets: ["StationsFeature"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "1.15.1"),
        .package(name: "Core", path: "../Core"),
        .package(name: "Networking", path: "../Networking"),
        .package(url: "https://github.com/uber/ios-snapshot-test-case.git", from: "8.0.0")
    ],
    targets: [
        .target(
            name: "StationsFeature",
            dependencies: [
                "Networking",
                "Core",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
            ]
        ),
        .testTarget(
            name: "StationsFeatureTests",
            dependencies: [
                "StationsFeature",
                "Core",
                .product(name: "iOSSnapshotTestCase", package: "ios-snapshot-test-case")
            ]
        )
    ]
)

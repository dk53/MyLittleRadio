// swift-tools-version: 5.7
import PackageDescription

let package = Package(
    name: "StationDetailsFeature",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "StationDetailsFeature",
            targets: ["StationDetailsFeature"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "1.15.1"),
        .package(name: "AudioPlayerFeature", path: "../AudioPlayerFeature"),
        .package(name: "Core", path: "../Core"),
        .package(url: "https://github.com/uber/ios-snapshot-test-case.git", from: "8.0.0")
    ],
    targets: [
        .target(
            name: "StationDetailsFeature",
            dependencies: [
                "AudioPlayerFeature",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
            ]
        ),
        .testTarget(
            name: "StationDetailsFeatureTests",
            dependencies: [
                "StationDetailsFeature",
                "Core",
                .product(name: "iOSSnapshotTestCase", package: "ios-snapshot-test-case")
            ]
        ),
    ]
)

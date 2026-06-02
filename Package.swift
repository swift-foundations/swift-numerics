// swift-tools-version: 6.3.1

import PackageDescription

let package = Package(
    name: "swift-numerics",
    platforms: [
        .macOS(.v26),
        .iOS(.v26),
        .tvOS(.v26),
        .watchOS(.v26),
        .visionOS(.v26)
    ],
    products: [
        .library(name: "Numerics", targets: ["Numerics"])
    ],
    dependencies: [
        .package(url: "https://github.com/swift-ieee/swift-ieee-754.git", branch: "main"),
        .package(url: "https://github.com/swift-primitives/swift-numeric-primitives.git", branch: "main"),
        .package(url: "https://github.com/swift-iso/swift-iso-9899.git", branch: "main")
    ],
    targets: [
        .target(
            name: "Numerics",
            dependencies: [
                .product(name: "IEEE 754", package: "swift-ieee-754"),
                .product(name: "Numeric Primitives", package: "swift-numeric-primitives"),
                .product(name: "Real Primitives", package: "swift-numeric-primitives"),
                .product(name: "Integer Primitives", package: "swift-numeric-primitives"),
                .product(name: "ISO 9899 Core", package: "swift-iso-9899")
            ]
        ),
        .testTarget(
            name: "Numerics Tests",
            dependencies: [
                "Numerics",
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("LifetimeDependence"),
        .enableExperimentalFeature("Lifetimes"),
        .enableExperimentalFeature("SuppressedAssociatedTypes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
        .enableUpcomingFeature("LifetimeDependence"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}

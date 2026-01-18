// swift-tools-version: 6.2

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
        .package(path: "../../swift-standards/swift-ieee-754"),
        .package(path: "../../swift-primitives/swift-numeric-primitives")
    ],
    targets: [
        .target(
            name: "Numerics",
            dependencies: [
                .product(name: "IEEE 754", package: "swift-ieee-754"),
                .product(name: "Numeric Primitives", package: "swift-numeric-primitives"),
                .product(name: "Real Primitives", package: "swift-numeric-primitives"),
                .product(name: "Integer Primitives", package: "swift-numeric-primitives")
            ]
        )
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin].contains(target.type) {
    target.swiftSettings = (target.swiftSettings ?? []) + [
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility")
    ]
}

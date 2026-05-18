// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "SwiftDesignSystem",
    platforms: [
        .iOS(.v17),
        .macOS(.v14)
    ],
    products: [
        .library(
            name: "SwiftDesignSystem",
            targets: ["SwiftDesignSystem"])
    ],
    targets: [
        .target(
            name: "SwiftDesignSystem",
            dependencies: [],
            path: "Sources/SwiftDesignSystem"
        ),
        .testTarget(
            name: "SwiftDesignSystemTests",
            dependencies: ["SwiftDesignSystem"],
            path: "Tests/SwiftDesignSystemTests"
        )
    ]
)

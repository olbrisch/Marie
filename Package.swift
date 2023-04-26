// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MarieLib",
    platforms: [.iOS(.v12)],
    products: [
        .library(
            name: "MarieLib",
            targets: ["Core"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Core",
            dependencies: [],
            path: "Sources/Core",
            resources: [.process("Assets.xcassets")]),
    ]
)

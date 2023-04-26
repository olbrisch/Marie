// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MarieLib",
    platforms: [.iOS(.v12)],
    products: [
        .library(
            name: "MarieLib",
            targets: ["MarieCore", "MarieExtensions", "MarieModels", "MarieScenes"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "MarieCore",
            dependencies: [],
            path: "Sources/Core",
            resources: [.process("Assets.xcassets")]),
        .target(
            name: "MarieExtensions",
            dependencies: [],
            path: "Sources/Extensions"),
        .target(
            name: "MarieModels",
            dependencies: [],
            path: "Sources/Models"),
        .target(
            name: "MarieScenes",
            dependencies: [],
            path: "Sources/Scenes"),
    ]
)

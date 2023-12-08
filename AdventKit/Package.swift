// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AdventKit",
    products: [
        .library(
            name: "AdventKit",
            targets: ["AdventKit"]),
    ],
    targets: [
        .target(
            name: "AdventKit"),
        .testTarget(
            name: "AdventKitTests",
            dependencies: ["AdventKit"]),
    ]
)

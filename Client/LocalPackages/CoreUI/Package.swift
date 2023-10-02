// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CoreUI",
    products: [
        .library(
            name: "CoreUI",
            targets: ["CoreUI"]
        )
    ],
    targets: [
        .target(
            name: "CoreUI",
            dependencies: [],
            path: "Sources"
        ),
        .testTarget(
            name: "CoreUITests",
            dependencies: ["CoreUI"]
        )
    ]
)

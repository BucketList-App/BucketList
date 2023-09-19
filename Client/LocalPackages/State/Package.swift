// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "State",
    products: [
        .library(
            name: "State",
            targets: ["State"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/ReSwift/ReSwift.git", from: "6.0.0")
    ],
    targets: [
        .target(
            name: "State",
            dependencies: [
                .byName(name: "ReSwift")
            ]
        ),
        .testTarget(
            name: "StateTests",
            dependencies: ["State"]
        )
    ]
)

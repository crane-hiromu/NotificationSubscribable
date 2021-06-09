// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NotificationSubscribable",
    products: [
        .library(
            name: "NotificationSubscribable",
            targets: ["NotificationSubscribable"]),
    ],
    dependencies: [
        .package(url: "https://github.com/crane-hiromu/CombineStorable.git", from: "1.1.0")
    ],
    targets: [
        .target(
            name: "NotificationSubscribable",
            dependencies: ["CombineStorable"]),
        .testTarget(
            name: "NotificationSubscribableTests",
            dependencies: ["NotificationSubscribable", "CombineStorable"]),
    ]
)

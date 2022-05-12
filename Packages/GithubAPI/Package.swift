// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GithubAPI",
    platforms: [
        .iOS(.v15),
    ],
    products: [
        .library(
            name: "GithubAPI",
            targets: ["GithubAPI"]),
    ],
    dependencies: [
        .package(name: "HTTPClient", path: "../HTTPClient")
    ],
    targets: [
        .target(
            name: "GithubAPI",
            dependencies: ["HTTPClient"]),
        .testTarget(
            name: "GithubAPITests",
            dependencies: ["GithubAPI"]),
    ]
)

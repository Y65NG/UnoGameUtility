// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UnoGameUtility",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "UnoGame",
            targets: ["UnoGameUtility"]),
        .library(name: "Websocket", targets: ["UnoGameUtility"]),
    ], dependencies: [
        .package(url: "https://github.com/daltoniam/Starscream", .upToNextMajor(from: "4.0.8")),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "UnoGameUtility",
            dependencies: [
                .product(name: "Starscream", package: "Starscream"),
                
            ]
        ),
//        .target(name: "UnoGame"),

        .testTarget(
            name: "UnoGameUtilityTests",
            dependencies: ["UnoGameUtility"]),
    ])

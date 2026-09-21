// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "DyslexicoKit",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "DyslexicoKit",
            targets: ["DyslexicoKit"]
        )
    ],
    targets: [
        .target(
            name: "DyslexicoKit",
            path: "Sources/DyslexicoKit",
            resources: [
                .process("Assets")
            ]
        ),
        .testTarget(
            name: "DyslexicoKitTests",
            dependencies: ["DyslexicoKit"],
            path: "Tests/DyslexicoKitTests"
        )
    ]
)

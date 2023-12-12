// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "Moonlight",
    platforms: [.macOS(.v10_15),
                .iOS(.v13),
                .tvOS(.v13),
                .watchOS(.v6)],
    products: [
        .library(
            name: "Moonlight",
            targets: ["Moonlight"]),
    ],
    dependencies: [
    .package(url: "https://github.com/isabellanoriega99/Moonlight2", from: "latest"),
    ],
    targets: [
        .target(
            name: "Moonlight",
            dependencies: []),
        .testTarget(
            name: "MoonlightTests",
            dependencies: ["Moonlight"]),
    ]
)

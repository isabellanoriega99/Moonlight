// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "Moonlight",
    platforms: [.macOS(.v10_15),
                .iOS(.v13),
                .tvOS(.v13),
                .watchOS(.v5)],
    products: [.library(
            name: "Moonlight",
            targets: ["Moonlight"]),
    ],
    targets: [.target(
            name: "Moonlight",
            path: "Sources"),
        .testTarget(
            name: "MoonlightTests",
            dependencies: ["Moonlight"],
            path: "Tests"),
    ],
    swiftLanguageVersions: [.v5]
)

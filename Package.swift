// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "StarCoordinates",
    products: [
        .library(
            name: "StarCoordinates",
            targets: ["StarCoordinates"]),
    ],
    dependencies: [
      .package(name: "WrappedSGP4", url: "../WrappedSGP4", branch: "main")
    ],
    targets: [
        .target(
            name: "StarCoordinates",
            dependencies: []),
        .testTarget(
            name: "StarCoordinatesTests",
            dependencies: ["StarCoordinates", "WrappedSGP4"]),
    ]
)

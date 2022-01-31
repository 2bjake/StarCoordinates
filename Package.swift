// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "StarCoordinates",
    platforms: [.iOS(.v15), .macOS(.v12)],
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
            dependencies: ["WrappedSGP4"]),
        .testTarget(
            name: "StarCoordinatesTests",
            dependencies: ["StarCoordinates", "WrappedSGP4"]),
    ]
)

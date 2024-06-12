// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "Tmtplayer",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "Tmtplayer",
            targets: ["TMTPlayerPlugin"])
    ],
    dependencies: [
        .package(url: "https://github.com/ionic-team/capacitor-swift-pm.git", branch: "main")
    ],
    targets: [
        .target(
            name: "TMTPlayerPlugin",
            dependencies: [
                .product(name: "Capacitor", package: "capacitor-swift-pm"),
                .product(name: "Cordova", package: "capacitor-swift-pm")
            ],
            path: "ios/Sources/TMTPlayerPlugin"),
        .testTarget(
            name: "TMTPlayerPluginTests",
            dependencies: ["TMTPlayerPlugin"],
            path: "ios/Tests/TMTPlayerPluginTests")
    ]
)
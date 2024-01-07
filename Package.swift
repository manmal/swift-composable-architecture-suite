// swift-tools-version:5.9

import CompilerPluginSupport
import PackageDescription

let package = Package(
    name: "swift-composable-architecture-suite",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .tvOS(.v13),
        .watchOS(.v6),
    ],
    products: [
        .library(
            name: "_ComposableArchitecture",
            targets: ["_ComposableArchitecture"]
        ),
        .library(
            name: "_CasePaths",
            targets: ["_CasePaths"]
        ),
        .library(
            name: "_Clocks",
            targets: ["_Clocks"]
        ),
        .library(name: "_Collections", targets: ["_Collections"]),
        .library(name: "_DequeModule", targets: ["_DequeModule"]),
        .library(name: "_OrderedCollections", targets: ["_OrderedCollections"]),
        .library(
            name: "_ConcurrencyExtras",
            targets: ["_ConcurrencyExtras"]
        ),
        .library(
            name: "_CustomDump",
            targets: ["_CustomDump"]
        ),
        .library(
            name: "_Dependencies",
            targets: ["_Dependencies"]
        ),
        .library(
            name: "_DependenciesMacros",
            targets: ["_DependenciesMacros"]
        ),
        .library(
            name: "_IdentifiedCollections",
            targets: ["_IdentifiedCollections"]
        ),
        .library(
            name: "_SwiftUINavigation",
            targets: ["_SwiftUINavigation"]
        ),
        .library(
            name: "_SwiftUINavigationCore",
            targets: ["_SwiftUINavigationCore"]
        ),
        .library(name: "_XCTestDynamicOverlay", targets: ["_XCTestDynamicOverlay"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.0.0"),
        .package(url: "https://github.com/apple/swift-syntax", from: "509.0.0"),
    ],
    targets: [
        // ComposableArchitecture
        .target(
            name: "_ComposableArchitecture",
            dependencies: [
                "_ComposableArchitectureMacros",
                "_CasePaths",
                "_CombineSchedulers",
                "_ConcurrencyExtras",
                "_CustomDump",
                "_Dependencies",
                "_DependenciesMacros",
                "_IdentifiedCollections",
                "_OrderedCollections",
                "_SwiftUINavigationCore",
                "_XCTestDynamicOverlay",
            ]
        ),
        .macro(
            name: "_ComposableArchitectureMacros",
            dependencies: [
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
            ]
        ),
        // CasePaths
        .target(
            name: "_CasePaths",
            dependencies: [
                "_CasePathsMacros",
                "_XCTestDynamicOverlay",
            ]
        ),
        .macro(
            name: "_CasePathsMacros",
            dependencies: [
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
            ]
        ),
        // Clocks
        .target(
            name: "_Clocks",
            dependencies: [
                "_ConcurrencyExtras",
                "_XCTestDynamicOverlay",
            ]
        ),
        // Collections
        .target(
            name: "_Collections",
            dependencies: [
                "_DequeModule",
                "_OrderedCollections",
            ],
            path: "Sources/_Collections",
            exclude: ["CMakeLists.txt"]
        ),
        .target(
          name: "_DequeModule",
          exclude: ["CMakeLists.txt"]),
        .target(
          name: "_OrderedCollections",
          exclude: ["CMakeLists.txt"]),
        // ConcurrencyExtras
        .target(
            name: "_ConcurrencyExtras"
        ),
        // CustomDump
        .target(
            name: "_CustomDump",
            dependencies: [
                "_XCTestDynamicOverlay",
            ]
        ),
        // CombineSchedulers
        .target(
          name: "_CombineSchedulers",
          dependencies: [
            "_ConcurrencyExtras",
            "_XCTestDynamicOverlay",
          ]
        ),
        // Dependencies
        .target(
            name: "_Dependencies",
            dependencies: [
                "_Clocks",
                "_CombineSchedulers",
                "_ConcurrencyExtras",
                "_XCTestDynamicOverlay",
            ]
        ),
        .target(
            name: "_DependenciesMacros",
            dependencies: [
                "_DependenciesMacrosPlugin",
                "_XCTestDynamicOverlay",
            ]
        ),
        .macro(
            name: "_DependenciesMacrosPlugin",
            dependencies: [
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
            ]
        ),
        // IdentifiedCollections
        .target(
            name: "_IdentifiedCollections",
            dependencies: [
                "_OrderedCollections",
            ]
        ),
        // SwiftUINavigation
        .target(
            name: "_SwiftUINavigation",
            dependencies: [
                "_SwiftUINavigationCore",
                "_CasePaths",
            ]
        ),
        .target(
            name: "_SwiftUINavigationCore",
            dependencies: [
                "_CustomDump",
                "_XCTestDynamicOverlay",
            ]
        ),
        // XCTestDynamicOverlay
        .target(name: "_XCTestDynamicOverlay"),
    ]
)

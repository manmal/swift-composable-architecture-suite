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
            name: "ComposableArchitecture",
            targets: ["ComposableArchitecture"]
        ),
        .library(
            name: "CasePaths",
            targets: ["CasePaths"]
        ),
        .library(
            name: "Clocks",
            targets: ["Clocks"]
        ),
        .library(name: "Collections", targets: ["Collections"]),
        .library(name: "DequeModule", targets: ["DequeModule"]),
        .library(name: "OrderedCollections", targets: ["OrderedCollections"]),
        .library(
            name: "ConcurrencyExtras",
            targets: ["ConcurrencyExtras"]
        ),
        .library(
            name: "CustomDump",
            targets: ["CustomDump"]
        ),
        .library(
            name: "Dependencies",
            targets: ["Dependencies"]
        ),
        .library(
            name: "DependenciesMacros",
            targets: ["DependenciesMacros"]
        ),
        .library(
            name: "IdentifiedCollections",
            targets: ["IdentifiedCollections"]
        ),
        .library(
            name: "SwiftUINavigation",
            targets: ["SwiftUINavigation"]
        ),
        .library(
            name: "SwiftUINavigationCore",
            targets: ["SwiftUINavigationCore"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.0.0"),
        .package(url: "https://github.com/apple/swift-syntax", from: "509.0.0"),
        .package(url: "https://github.com/pointfreeco/xctest-dynamic-overlay", from: "1.0.0"),
    ],
    targets: [
        // ComposableArchitecture
        .target(
            name: "ComposableArchitecture",
            dependencies: [
                "ComposableArchitectureMacros",
                "CasePaths",
                "CombineSchedulers",
                "ConcurrencyExtras",
                "CustomDump",
                "Dependencies",
                "DependenciesMacros",
                "IdentifiedCollections",
                "OrderedCollections",
                "SwiftUINavigationCore",
                .product(name: "XCTestDynamicOverlay", package: "xctest-dynamic-overlay"),
            ]
        ),
        .macro(
            name: "ComposableArchitectureMacros",
            dependencies: [
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
            ]
        ),
        // CasePaths
        .target(
            name: "CasePaths",
            dependencies: [
                "CasePathsMacros",
                .product(name: "XCTestDynamicOverlay", package: "xctest-dynamic-overlay"),
            ]
        ),
        .macro(
            name: "CasePathsMacros",
            dependencies: [
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
            ]
        ),
        // Clocks
        .target(
            name: "Clocks",
            dependencies: [
                "ConcurrencyExtras",
                .product(name: "XCTestDynamicOverlay", package: "xctest-dynamic-overlay"),
            ]
        ),
        // Collections
        .target(
            name: "Collections",
            dependencies: [
                "DequeModule",
                "OrderedCollections",
            ],
            path: "Sources/Collections",
            exclude: ["CMakeLists.txt"]
        ),
        .target(
          name: "DequeModule",
          exclude: ["CMakeLists.txt"]),
        .target(
          name: "OrderedCollections",
          exclude: ["CMakeLists.txt"]),
        // ConcurrencyExtras
        .target(
            name: "ConcurrencyExtras"
        ),
        // CustomDump
        .target(
            name: "CustomDump",
            dependencies: [
                .product(name: "XCTestDynamicOverlay", package: "xctest-dynamic-overlay"),
            ]
        ),
        // CombineSchedulers
        .target(
          name: "CombineSchedulers",
          dependencies: [
            "ConcurrencyExtras",
            .product(name: "XCTestDynamicOverlay", package: "xctest-dynamic-overlay"),
          ]
        ),
        // Dependencies
        .target(
            name: "Dependencies",
            dependencies: [
                "Clocks",
                "CombineSchedulers",
                "ConcurrencyExtras",
                .product(name: "XCTestDynamicOverlay", package: "xctest-dynamic-overlay"),
            ]
        ),
        .target(
            name: "DependenciesMacros",
            dependencies: [
                "DependenciesMacrosPlugin",
                .product(name: "XCTestDynamicOverlay", package: "xctest-dynamic-overlay"),
            ]
        ),
        .macro(
            name: "DependenciesMacrosPlugin",
            dependencies: [
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
            ]
        ),
        // IdentifiedCollections
        .target(
            name: "IdentifiedCollections",
            dependencies: [
                "OrderedCollections",
            ]
        ),
        // SwiftUINavigation
        .target(
            name: "SwiftUINavigation",
            dependencies: [
                "SwiftUINavigationCore",
                "CasePaths",
            ]
        ),
        .target(
            name: "SwiftUINavigationCore",
            dependencies: [
                "CustomDump",
                .product(name: "XCTestDynamicOverlay", package: "xctest-dynamic-overlay"),
            ]
        ),
    ]
)

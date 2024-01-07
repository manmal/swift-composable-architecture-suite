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
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.0.0"),
        .package(url: "https://github.com/apple/swift-syntax", from: "509.0.0"),
        .package(url: "https://github.com/google/swift-benchmark", from: "0.1.0"),
        .package(url: "https://github.com/pointfreeco/swift-macro-testing", from: "0.2.0"),
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
        .testTarget(
            name: "ComposableArchitectureTests",
            dependencies: [
                "ComposableArchitecture",
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
        .testTarget(
            name: "CasePathsMacrosTests",
            dependencies: [
                "CasePathsMacros",
                .product(name: "MacroTesting", package: "swift-macro-testing"),
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
            exclude: ["CMakeLists.txt"],
            swiftSettings: settings
        ),
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
    ]
)

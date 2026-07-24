// Copyright 2026 Anthropic PBC
// SPDX-License-Identifier: Apache-2.0

// swift-tools-version: 6.2
import PackageDescription

let package = Package(
  name: "ClaudeForFoundationModels",
  // The bridge remains availability-gated to OS 27, while the lower iOS and
  // macOS declarations allow apps supporting older releases to weak-link it.
  // Version strings are used because the corresponding constants require
  // newer PackageDescription APIs.
  platforms: [
    .iOS("17.0"), .macOS("14.0"), .visionOS("27.0"), .watchOS("27.0"),
  ],
  products: [
    .library(name: "ClaudeForFoundationModels", targets: ["ClaudeForFoundationModels"])
  ],
  targets: [
    // Internal Messages API client. No FoundationModels dependency.
    .target(name: "ClaudeAPI"),

    // FoundationModels ↔ Messages API bridge.
    .target(
      name: "ClaudeForFoundationModels",
      dependencies: ["ClaudeAPI"]
    ),

    // Runnable usage example (`swift run ClaudeExample`). Deliberately not a
    // product — it exists to document the SDK, not to be depended on.
    .executableTarget(
      name: "ClaudeExample",
      dependencies: ["ClaudeForFoundationModels"],
      path: "Examples/ClaudeExample"
    ),

    .testTarget(
      name: "ClaudeAPITests",
      dependencies: ["ClaudeAPI"]
    ),
    .testTarget(
      name: "ClaudeForFoundationModelsTests",
      dependencies: ["ClaudeForFoundationModels"]
    ),
  ]
)

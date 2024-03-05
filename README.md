# Bitso Coding Challenge

<!-- Badges -->

![SW][swift_badge] ![XC][xcode_badge] ![SL][swiftlint_badge]

<!-- Contents -->

## Table of Contents

1. [Getting Started](#getting-started)
2. [Dependencies](#dependencies)
3. [Modules](#modules)
4. [Patterns](#patterns)
5. [Testing](#testing)

## Getting Started

To run the app, open the [BitsoChallenge workspace](./BitsoChallenge.xcworkspace) and run the [BitsoShell](./BitsoShell) scheme.

The local dev environment can be set up using the [Tools/setup](./Tools/setup) script:

- will install the [Mint Package Manager](https://github.com/yonaskolb/Mint)
- will bootstrap all Mint dependencies
- set up the [PreCommit Script](./Tools/pre-commit)

Once we open Xcode, all packages will be resolved automatically.

## Dependencies

The only 3rd party dependency used in this project is [pointfreeco/swift-snapshot-testing](https://github.com/pointfreeco/swift-snapshot-testing).
This dependency is used to perform snapshot comparison tests.

## Modules

The workspace contains different modules:

- [BitsoShell](./BitsoShell): is the main app shell.
- [BitsoUI](./BitsoUI): mini Design System
- [BitsoNet](./BitsoNet): utils to perform network calls
- [BitsoKit](./BitsoKit): general utils to be used across all modules
- [BitsoBookModule](./BitsoBookModule): the module that provides features related to books

Each of these modules are Local Swift Packages.

## Patterns

Across this app, we will use:

- **MVVM-C** (Model-View-ViewModel-Coordinator) architectural pattern
- **Dependency Injection** through initializer
- **Async/Await** patterns to perform background tasks
- **Router** pattern to manage navigation between SwiftUI views

## Testing

This project uses two different testing approaches:

- **Unit Tests**: Tests each logic component separately
- **Snapshot Tests**: Tests view components by comparing them with a pre-recorded baseline

Each module can be tested independently using its own scheme:

- Select the module scheme: `Xcode -> Product -> Scheme -> {module scheme}` (e.g. `BitsoNet`)
- Run tests: `Xcode -> Product -> Test`

And the modules that support Snapshot testing will provide a separate scheme:

- Select the snapshot scheme: `Xcode -> Product -> Scheme -> {snaphot tests scheme}` (e.g. `BitsoUISnapshotTests`)
- Run tests: `Xcode -> Product -> Test`

> :exclamation: Snapshots need to run using an **iPhone 14 Pro** with **iOS 16.2** simulator.

> :grey_exclamation: To _record_ the snapshot tests, the environment configuration `RECORD_SNAPSHOTS` needs to be set to `true`.

## Test Plans

The workspace also contains two test-plans that run all tests for all modules:

- [Unit Test Plan](./BitsoShellTests.xctestplan)
- [Snapshots Test Plan](./BitsoShellSnapshots.xctestplan)

These can be run:

- Select the test plan: `Xcode -> Product -> Scheme -> {test plan}`
- Run tests: `Xcode -> Product -> Test`

<!-- Badge Links -->

[swift_badge]: https://img.shields.io/badge/Swift-5%2e7%2e2-red?logo=swift
[xcode_badge]: https://img.shields.io/badge/Xcode-14%2e2-blue?logo=xcode
[swiftlint_badge]: https://img.shields.io/badge/SwiftLint-0%2E42%2E0-green?logo=xcode

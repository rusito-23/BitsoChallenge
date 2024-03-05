# Bitso Coding Challenge

<!-- Badges -->

![SW][swift_badge] ![XC][xcode_badge] ![SL][swiftlint_badge]

<!-- Contents -->

## Table of Contents

1. [Getting Started](#getting-started)
2. [Architecture](#architecture)
3. [Modules](#modules)
4. [Testing](#testing)

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

## Patterns

Across this app, we will use:

- **MVVM-C** (Model-View-ViewModel-Coordinator) architectural pattern
- **Dependency Injection** through initializer
- **Async/Await** patterns to perform background tasks
- **Router** pattern to manage navigation between SwiftUI views

## Modules

The workspace contains different modules:

- [BitsoShell](./BitsoShell): is the main app shell.
- [BitsoUI](./BitsoUI): mini Design System
- [BitsoNet](./BitsoNet): utils to perform network calls
- [BitsoKit](./BitsoKit): general utils to be used across all modules
- [BitsoBookModule](./BitsoBookModule): the

Each of these modules are Local Swift Packages.

## Testing

This project uses two different testing approaches:

- Unit Tests: Tests each logic component separately
- Snapshot Tests: Tests view components by comparing them with a pre-recorded baseline

TODO: Test Plans!

<!-- Badge Links -->

[swift_badge]: https://img.shields.io/badge/Swift-5%2e7%2e2-red?logo=swift
[xcode_badge]: https://img.shields.io/badge/Xcode-14%2e2-blue?logo=xcode
[swiftlint_badge]: https://img.shields.io/badge/SwiftLint-0%2E42%2E0-green?logo=xcode

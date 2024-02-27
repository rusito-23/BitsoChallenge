# Bitso Coding Challenge

<!-- Badges -->

![SW][swift_badge] ![XC][xcode_badge] ![SL][swiftlint_badge]

<!-- Contents -->

## Table of Contents

1. [Getting Started](#getting-started)
2. [Architecture](#architecture)
3. [Modules](#modules)

## Getting Started

To run the app, open the [BitsoChallenge workspace](./BitsoChallenge.xcworkspace) and run the [BitsoShell](./BitsoShell) scheme.

The local dev environment can be set up using the [Tools/setup](./Tools/setup) script:

- will install the [Mint Package Manager](https://github.com/yonaskolb/Mint)
- will bootstrap all Mint dependencies
- set up the [PreCommit Script](./Tools/pre-commit)

This project does not use any third party dependency.

## Architecture

The workspace contains different projects:

- [BitsoShell](./BitsoShell) is the main app shell.
- [BitsoUI](./BitsoUI) provides UI components to keep a consistent style.
- [BitsoKit](./BitsoKit) provides the tools to build the domain layer.
- [Features](./Features) contains the feature modules.

## Modules

<!-- Badge Links -->

[swift_badge]: https://img.shields.io/badge/Swift-5%2e7%2e2-red?logo=swift
[xcode_badge]: https://img.shields.io/badge/Xcode-14%2e2-blue?logo=xcode
[swiftlint_badge]: https://img.shields.io/badge/SwiftLint-0%2E42%2E0-green?logo=xcode

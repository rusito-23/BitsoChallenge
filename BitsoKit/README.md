# BitsoKit

A collection of general purpose utils to be used across all modules.

## Logging

Provides a logger named `Log`, which can accessed by a global instance `log`. 
This is a wrapper around `os_log` that ensures all logs have useful information 
like date, file and line number.

## Localization

Provides an interface to work with Localized content. By conforming to the `LocalizableContent` 
protocol, we ensure every localizable resource can be formatted with parameters.

This becomes very useful to keep localizable content organized in enums:

```swift
enum Content: LocalizableContent {
  case some = "SOME"
}

// then
Content.some.localized()
``` 

## Module & Navigation

Provides common interfaces and components that can be reused across modules to navigate:

- `Router`: Holds the navigation path
- `Module`: Defines how the exposure class of a module should look like, 
  exposing its public destinations and providing its navigation.

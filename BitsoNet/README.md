# BitsoNet

A collection of utils to interact with a network service.

## `NetworkClient`

Provides an interface to perform network requests without having to interact directly with `URLSession`, which can be hard to mock for unit tests.

> :warning: Note: it will only handle parsable requests at the moment (e.g. doesn't support image requests).

### Benefits and responsibilities

- Handles the parsing for both the request and response payloads
- Handles different kinds of errors that can occur when performing a request, combining them into a single error enum
- Provides an asynchronous interface

## Protocols

Provides a collection of protocols that need to be used to perform requests:

- [Domain](./Sources/Protocols/Domain.swift)
- [Endpoint](./Sources/Protocols/Endpoint.swift)
- [Header](./Sources/Protocols/Header.swift)

## Constants and utils

Provides a set of constants and utils to prevent using literals when interacting with the module:

- [Empty](./Sources/Constants/Empty.swift)
- [HTTP](./Sources/Constants/HTTP.swift)
- [ServiceError](./Sources/Constants/ServiceError.swift)

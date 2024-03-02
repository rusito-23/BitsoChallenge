import Foundation

extension HeaderMock {
    /// A mock header that defines content-type as XML.
    static var contentTypeXML: HeaderMock {
        HeaderMock(key: "Content-Type", value: "application/xml")
    }

    /// A mock header that defines a generic key-value pair.
    static var generic: HeaderMock {
        HeaderMock(key: "KeyMock", value: "ValueMock")
    }
}

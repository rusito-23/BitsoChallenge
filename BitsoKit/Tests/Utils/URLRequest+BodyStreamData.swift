import Foundation

extension URLRequest {
    /// Since URL requests HTTP body is converted to a data stream upon URLProtocol loading,
    /// we need a way of retrieving that data to be able to check it.
    var bodyStreamData: Data? {
        guard let bodyStream = httpBodyStream else {
            return nil
        }

        bodyStream.open()
        let bufferSize: Int = 16
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: bufferSize)
        var data = Data()

        while bodyStream.hasBytesAvailable {
            let count = bodyStream.read(buffer, maxLength: bufferSize)
            data.append(buffer, count: count)
        }

        buffer.deallocate()
        bodyStream.close()
        return data
    }
}

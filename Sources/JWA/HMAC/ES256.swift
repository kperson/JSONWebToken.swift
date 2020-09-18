import Foundation
import CryptorECC


public class ES256CAlgorithm: Algorithm, SignAlgorithm, VerifyAlgorithm {

    public let key: Data

    public let name: String = "ES256"

    public init(key: Data) {
        self.key = key
    }
    
    public func sign(_ message: Data) -> Data {
        let keyString = String(data: key, encoding: .utf8)!
        if #available(macOS 10.13, iOS 11, watchOS 4.0, tvOS 11.0, *) {
            let privateKey = try! ECPrivateKey(key: keyString)
            let signedData = try! message.sign(with: privateKey)
            return signedData.r + signedData.s
        }
        else {
            return Data()
        }
    }
    

}

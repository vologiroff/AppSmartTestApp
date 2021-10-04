//
//  Encryption.swift
//  AppSmartTestApp
//
//  Created by Kantemir Vologirov on 10/3/21.
//

import Foundation
import CommonCrypto

public func encryptHashParameterWithMD5(string: String) -> String? {
    /*
     Encrypts a string into a hashed string (of HEX format)
    */
    guard let md5Data = MD5(string: string) else { return nil }
    let md5Hex = md5Data.map { String(format: "%02hhx", $0) }.joined()
    
    return md5Hex
}

private func MD5(string: String) -> Data? {
    
    guard let messageData = string.data(using: .utf8) else {
        print("Failed to cast message to data!")
        return nil
    }
    
    let length = Int(CC_MD5_DIGEST_LENGTH)
    var digestData = Data(count: length)
    
    _ = digestData.withUnsafeMutableBytes { digestBytes in
        messageData.withUnsafeBytes { messageBytes -> UInt8 in
            if let messageBytesBaseAddress = messageBytes.baseAddress,
               let digestBytesBindMemory = digestBytes.bindMemory(to: UInt8.self).baseAddress {
                
                let messageLength = CC_LONG(messageData.count)
                CC_MD5(messageBytesBaseAddress, messageLength, digestBytesBindMemory)
            }
            return 0
        }
    }
    return digestData
}

public let timestamp = String(Int(Date.init().timeIntervalSince1970))


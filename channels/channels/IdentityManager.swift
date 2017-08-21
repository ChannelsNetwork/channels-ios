//
//  IdentityManager.swift
//  channels
//
//  Created by Preet Shihn on 8/17/17.
//  Copyright © 2017 Hivepoint, Inc. All rights reserved.
//

import Foundation

class IdentityManager {
    static let instance = IdentityManager()
    
    private let applicationTag = "hivepoint.channels"
    private let tagPrivate: String
    private let tagPublic: String
    private let tagEthPublic: String
    private let tagEthAddress: String
    
    private var privateKey: String?
    private var publicKey: String?
    private var ethPublicKey: String?
    private var ethAddress: String?
    
    private init() {
        self.tagPrivate = applicationTag + ".private"
        self.tagPublic = applicationTag + ".public"
        self.tagEthPublic = applicationTag + ".ethPublic"
        self.tagEthAddress = applicationTag + ".ethAddress"
    }
    
    func ensureKey(autoGenerate: Bool) -> Bool {
        if self.privateKey != nil && self.publicKey != nil && self.ethPublicKey != nil && self.ethAddress != nil {
            return true
        }
        if let loadedPrivate = loadKeyWithTag(self.tagPrivate) {
            if let loadedPublic = loadKeyWithTag(self.tagPublic) {
                if let loadedEthPublic = loadKeyWithTag(self.tagEthPublic) {
                    if let loadedEthAddress = loadKeyWithTag(self.tagEthAddress) {
                        self.privateKey = loadedPrivate
                        self.publicKey = loadedPublic
                        self.ethPublicKey = loadedEthPublic
                        self.ethAddress = loadedEthAddress
                        return true
                    }
                }
            }
        }
        if (autoGenerate) {
            return generateKeyPair()
        }
        return false
    }
    
    private func generateKeyPair() -> Bool {
        var keyData = Data(count: 32)
        let result = keyData.withUnsafeMutableBytes { (mutableBytes: UnsafeMutablePointer<UInt8>) -> Int32 in
            SecRandomCopyBytes(kSecRandomDefault, keyData.count, mutableBytes)
        }
        if result != errSecSuccess {
            print("Problem generating private key")
            return false
        }
        let keyString = keyData.base64EncodedString()
        print("private key: \(keyString)")
        
        guard let keys = JSUtils.instance.generateAddress(keyString) else {
            print("Failed to generate public address")
            return false
        }
        print("Public Keys and etherum address:\n\(keys)")
        
        self.privateKey = keyString
        self.publicKey = keys[0]
        self.ethPublicKey = keys[1]
        self.ethAddress = keys[2]
        
        guard storeKeyWithTag(self.tagPrivate, value: keyString) &&
              storeKeyWithTag(self.tagPublic, value: self.publicKey!) &&
              storeKeyWithTag(self.tagEthPublic, value: self.ethPublicKey!) &&
              storeKeyWithTag(self.tagEthAddress, value: self.ethAddress!) else {
            print("Failed to store keys in chain")
            return false
        }
        
        return true
    }
    
    private func storeKeyWithTag(_ tag: String, value: String) -> Bool {
        let data = value.data(using: String.Encoding.utf8)
        let addQuery: [String: Any] = [
            kSecClass as String: kSecClassKey,
            kSecAttrApplicationTag as String: tag,
            kSecValueData as String: data!
        ]
        SecItemDelete(addQuery as CFDictionary)
        let status = SecItemAdd(addQuery as CFDictionary, nil)
        guard status == errSecSuccess else {
            print("Failed to store key with tag \(tag)")
            return false
        }
        return true
    }
    
    private func loadKeyWithTag(_ tag: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassKey,
            kSecAttrApplicationTag as String: tag,
            kSecReturnData as String: kCFBooleanTrue,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var item: CFTypeRef?
        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &item)
        guard status == errSecSuccess else {
            print("Key with tag \(tag) not found")
            return nil
        }
        return String(data: item as! Data, encoding: String.Encoding.utf8)
    }
}

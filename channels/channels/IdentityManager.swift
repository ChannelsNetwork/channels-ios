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
    
    private var publicKey : SecKey?
    private var privateKey : SecKey?
    
    private init() {
//        self.privateKey = self.loadKey(self.applicationTag + "private")
//        self.publicKey = self.loadKey(self.applicationTag + "public")
    }
    
    private func loadKey(_ tag: String) -> SecKey? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassKey,
            kSecAttrKeyType as String: kSecAttrKeyTypeECSECPrimeRandom,
            kSecAttrApplicationTag as String: tag,
            kSecReturnRef as String: true
        ]
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        if status == errSecSuccess && item != nil {
            let key = item as! SecKey
            return key
        }
        return nil
    }
    
    func generateKeyPair() -> Bool {
        if self.publicKey != nil && self.privateKey != nil {
            return true
        }
        
        self.publicKey = nil
        self.privateKey = nil
        
        let keySize = 256
        let publicKeyParams: [String: Any] = [
            kSecAttrIsPermanent as String: true,
            kSecAttrApplicationTag as String: self.applicationTag + "public"
        ]
        let privateKeyParams: [String: Any] = [
            kSecAttrIsPermanent as String: true,
            kSecAttrApplicationTag as String: self.applicationTag + "private"
        ]
        let params: [String: Any] = [
            kSecAttrKeyType as String: kSecAttrKeyTypeECSECPrimeRandom,
            kSecAttrKeySizeInBits as String: keySize,
            kSecPrivateKeyAttrs as String: privateKeyParams,
            kSecPublicKeyAttrs as String: publicKeyParams
        ]
        let status: OSStatus = SecKeyGeneratePair(params as CFDictionary, &(self.publicKey), &(self.privateKey))
        return (status == errSecSuccess && self.publicKey != nil && self.privateKey != nil)
    }
}

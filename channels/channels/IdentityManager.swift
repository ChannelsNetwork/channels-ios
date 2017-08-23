//
//  IdentityManager.swift
//  channels
//
//  Created by Preet Shihn on 8/17/17.
//  Copyright © 2017 Hivepoint, Inc. All rights reserved.
//

import Foundation
import ObjectMapper


class IdentityManager {
    static let instance = IdentityManager()
    
    private var priv: String?
    private var privPem: String?
    private var pub: String?
    private var pubPem: String?
    private var pubEth: String?
    private var address: String?
    private var addressEth: String?
    
    private var userIdentity: UserIdentity?
    
    struct KeyTag {
        static let priv = "channels.identity.private"
        static let privPem = "channels.identity.private.pem"
        static let pub = "channels.identity.public"
        static let pubPem = "channels.identity.public.pem"
        static let pubEth = "channels.identity.public.eth"
        static let address = "channels.identity.address"
        static let addressEth = "channels.identity.address.eth"
    }
    
    private init() {
        self.priv = nil
        self.userIdentity = loadUserIdentity()
    }
    
    func ensureKey(autoGenerate: Bool) -> Bool {
        if self.priv != nil {
            return true
        }
        
        guard let priv = loadKeyWithTag(KeyTag.priv),
              let privPem = loadKeyWithTag(KeyTag.privPem),
              let pub = loadKeyWithTag(KeyTag.pub),
              let pubPem = loadKeyWithTag(KeyTag.pubPem),
              let pubEth = loadKeyWithTag(KeyTag.pubEth),
              let address = loadKeyWithTag(KeyTag.address),
              let addressEth = loadKeyWithTag(KeyTag.addressEth)
            else {
                if (autoGenerate) {
                    return generateKeyPair()
                }
                return false
        }
        
        self.priv = priv
        self.privPem = privPem
        self.pub = pub
        self.pubPem = pubPem
        self.pubEth = pubEth
        self.address = address
        self.addressEth = addressEth
        return true
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
        
        self.priv = keyString
        self.privPem = keys.privateKeyPem
        self.pub = keys.publicKey
        self.pubPem = keys.publicKeyPem
        self.pubEth = keys.ethPublic
        self.address = keys.address
        self.addressEth = keys.ethAddress
        
        guard storeKeyWithTag(KeyTag.priv, value: self.priv!) &&
              storeKeyWithTag(KeyTag.privPem, value: self.privPem!) &&
              storeKeyWithTag(KeyTag.pub, value: self.pub!) &&
              storeKeyWithTag(KeyTag.pubPem, value: self.pubPem!) &&
              storeKeyWithTag(KeyTag.pubEth, value: self.pubEth!) &&
              storeKeyWithTag(KeyTag.address, value: self.address!) &&
              storeKeyWithTag(KeyTag.addressEth, value: self.addressEth!)
            else {
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
    
    private func loadUserIdentity() -> UserIdentity? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: UserIdentity.ArchiveUrl.path) as? UserIdentity
    }
    
    private func saveUserIdentity(_ identity: UserIdentity) {
        self.userIdentity = identity
        let saved = NSKeyedArchiver.archiveRootObject(identity, toFile: UserIdentity.ArchiveUrl.path)
        if saved {
            print("User identity saved")
        } else {
            print("Failed to save user identity: \(saved)")
        }
    }
    
    func sign(_ obj: Mappable) -> String? {
        guard let json = obj.toJSONString() else {
            return nil
        }
        return JSUtils.instance.sign(value: json, privateKeyPem: self.privPem!)
    }
}

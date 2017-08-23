//
//  JSUtils.swift
//  channels
//
//  Created by Preet Shihn on 8/18/17.
//  Copyright © 2017 Hivepoint, Inc. All rights reserved.
//

import Foundation
import JavaScriptCore

struct GeneratedKeys {
    let privateKeyPem: String
    let publicKey: String
    let publicKeyPem: String
    let ethPublic: String
    let address: String
    let ethAddress: String
}

class JSUtils {
    static let instance = JSUtils()
    
    private let jsContext: JSContext!
    private var jsUtils: JSValue?
    
    private init() {
        self.jsContext = JSContext()
        
        self.jsContext.exceptionHandler = { context, exception in
            if let exc = exception {
                print("JS Exception:", exc.toString())
            }
        }
    }
    
    private func initializeJs() -> Bool {
        if self.jsUtils != nil {
            return true
        }
        if let jsSourcePath = Bundle.main.path(forResource: "channels-ios-jsutils", ofType: "js") {
            do {
                let jsSourceContents = try String(contentsOfFile: jsSourcePath)
                if (self.jsContext.evaluateScript(jsSourceContents)) != nil {
                    if let utilsVar = self.jsContext.objectForKeyedSubscript("jsUtils") {
                        self.jsUtils = utilsVar
                    }
                }
            } catch  {
                self.jsUtils = nil
                print(error.localizedDescription)
            }
        }
        return (self.jsUtils != nil)
    }
    
    func generateAddress(_ privateKey: String) -> GeneratedKeys? {
        if self.initializeJs() {
            if let result = self.jsUtils?.invokeMethod("generateAddress", withArguments: [privateKey]) {
                let ret = GeneratedKeys(
                    privateKeyPem: result.forProperty("privateKeyPem").toString(),
                    publicKey: result.forProperty("publicKey").toString(),
                    publicKeyPem: result.forProperty("publicKeyPem").toString(),
                    ethPublic: result.forProperty("ethPublic").toString(),
                    address: result.forProperty("address").toString(),
                    ethAddress: result.forProperty("ethAddress").toString()
                )
                return ret
            }
        }
        return nil
    }
    
    func sign(value: String, privateKeyPem: String) -> String? {
        if initializeJs() {
            if let result = self.jsUtils?.invokeMethod("sign", withArguments: [value, privateKeyPem]) {
                return result.toString()
            }
        }
        return nil
    }
}

//
//  RestService.swift
//  channels
//
//  Created by Preet Shihn on 8/23/17.
//  Copyright © 2017 Hivepoint, Inc. All rights reserved.
//

import Foundation

class RestService {
    
    static func Get<T: Serializable>(_ url: String, completion: @escaping (T?, Error?) -> Void) {
        let endPoint = URL(string: url)
        let task = URLSession.shared.dataTask(with: endPoint!) { (data: Data?, response: URLResponse?, er: Error?) in
            if (er != nil) {
                completion(nil, er)
            } else {
                if (data == nil) {
                    completion(nil, nil)
                } else {
                    let json = try? JSONSerialization.jsonObject(with: data!, options: [])
                    guard let jsonObj = json as? [String: Any] else {
                        completion(nil, SerializationError.missing("root"))
                        return
                    }
                    do {
                        let ret = try T.init(json: jsonObj)
                        completion(ret, nil)
                    } catch {
                        completion(nil, error)
                    }
                }
            }
        }
        task.resume()
    }
    
    private static func Fetch<T: Serializable>(_ url: String, method: String, body: Any?, completion: @escaping (T?, Error?) -> Void) {
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = method
        if body != nil {
            JSONSerialization.strin
        }
        
    }
    
//    var request = URLRequest(url: URL(string: "http://www.thisismylink.com/postName.php")!)
//    request.httpMethod = "POST"
//    let postString = "id=13&name=Jack"
//    request.httpBody = postString.data(using: .utf8)
}

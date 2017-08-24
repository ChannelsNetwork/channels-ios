//
//  RestService.swift
//  channels
//
//  Created by Preet Shihn on 8/23/17.
//  Copyright © 2017 Hivepoint, Inc. All rights reserved.
//

import Foundation
import ObjectMapper

class RestService {
    static func Get<T: Mappable>(_ url: String, completion: @escaping (T?, Error?) -> Void) {
        fetch(url, method: "GET", body: nil, completion: completion)
    }
    
    static func Post<T: Mappable>(_ url: String, body: Mappable?, completion: @escaping (T?, Error?) -> Void) {
        fetch(url, method: "POST", body: body, completion: completion)
    }
    
    private static func fetch<T: Mappable>(_ url: String, method: String, body: Mappable?, completion: @escaping (T?, Error?) -> Void) {
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = method
        if body != nil {
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = body!.toJSONString()?.data(using: .utf8)
        }
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, err: Error?) in
            if (err != nil) {
                completion(nil, err)
            } else {
                if (data == nil) {
                    completion(nil, nil)
                } else {
                    guard let jsonString = String.init(data: data!, encoding: .utf8) else {
                        completion(nil, nil)
                        return
                    }
                    guard let parsed = Mapper<T>().map(JSONString: jsonString) else {
                        completion(nil, ChannelsError.message("Failed to deserialize response: \(jsonString)"))
                        return
                    }
                    completion(parsed, nil)
                }
            }
        }
        task.resume()
    }
}

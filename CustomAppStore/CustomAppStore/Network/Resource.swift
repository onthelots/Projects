//
//  Resource.swift
//  CustomAppStore
//
//  Created by Jae hyuk Yim on 2023/04/30.
//

import Foundation

// Resource
struct Resource<T: Decodable> {
    var base: String
    var path: String
    var params: [String: String]
    var header: [String: String]
    
    var urlRequest: URLRequest? {
        
        // URLComponents - URL(base+path)
        var urlComponents = URLComponents(string: base + path)!
        
        // quearItems - 파라미터(params)
        let queryItems = params.map { (key: String, value: String) in
            URLQueryItem(name: key, value: value)
        }
        urlComponents.queryItems = queryItems
        
        // request (+header)
        var request = URLRequest(url: urlComponents.url!)
        header.forEach { (key: String, value: String) in
            request.addValue(value, forHTTPHeaderField: key)
        }
        
        // URLRequest (return request)
        return request
    }
    
    // initializer
    init(base: String, path: String, params: [String: String] = [:], header: [String: String] = [:]) {
        self.base = base
        self.path = path
        self.params = params
        self.header = header
    }
}

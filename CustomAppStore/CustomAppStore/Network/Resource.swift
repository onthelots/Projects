//
//  Resource.swift
//  CustomAppStore
//
//  Created by Jae hyuk Yim on 2023/04/30.
//

import Foundation

// MARK: - Resource
// Resource는 제너릭(T) 타입이며, Decodable 프로토콜을 채택함(JSON to Swift, 데이터 불러오기)
struct Resource<T: Decodable> {
    
    // url 데이터, 즉 Resource를 받아오기 위해 아래와 같은 프로퍼티를 선언함
    // 저장 프로퍼티로는 base, path, params, header
    var base: String
    var path: String
    var params: [String: String]
    var header: [String: String]
    
    // URLRequest : 데이터로 서버를 요청(request)
    // base, path, params, header의 값이 합쳐진 형태의 url을 반환하는 urlRequest 객체를 선언함
    var urlRequest: URLRequest? {
        
        // URLComponents - URL(base+path)
        var urlComponents = URLComponents(string: base + path)!
        
        // quearItems - 파라미터(params)
        let queryItems = params.map { (key: String, value: String) in
            URLQueryItem(name: key, value: value)
        }
        urlComponents.queryItems = queryItems
        
        // request
        var request = URLRequest(url: urlComponents.url!)
        header.forEach { (key: String, value: String) in
            request.addValue(value, forHTTPHeaderField: key)
        }
        
        // base, path, params, header의 값이 합쳐진 형태의 url을 반환
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

//
//  NetworkService.swift
//  CustomAppStore
//
//  Created by Jae hyuk Yim on 2023/04/30.
//

import Foundation
import Combine

// Defines the Network service errors.
enum NetworkError: Error {
    case invalidRequest
    case invalidResponse
    case responseError(statusCode: Int)
    case jsonDecodingError(error: Error)
}

// NetworkSevice (+ Combine)
final class NetworkService {
    
    // URLSession
    let session: URLSession
    
    // URLSessionConfiguration
    init(configuration: URLSessionConfiguration) {
        session = URLSession(configuration: configuration)
    }
    
    // decoding -> Resource<T> (Return AnyPublisher<T or Error>
    func load<T>(_ resource: Resource<T>) -> AnyPublisher<T, Error> {
        
        // errorhandling
        guard let request = resource.urlRequest else {
            return .fail(NetworkError.invalidRequest)
        }
        
        return session
            .dataTaskPublisher(for: request)
            .tryMap { result -> Data in
                guard let response = result.response as? HTTPURLResponse,
                      (200..<300).contains(response.statusCode)
                else {
                    let response = result.response as? HTTPURLResponse
                    let statusCode = response?.statusCode ?? -1
                    throw NetworkError.responseError(statusCode: statusCode)
                }
                return result.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

//
//  NetworkService.swift
//  CustomAppStore
//
//  Created by Jae hyuk Yim on 2023/04/30.
//

import Foundation
import Combine

// 에러타입
enum NetworkError: Error {
    case invalidRequest
    case invalidResponse
    case responseError(statusCode: Int)
    case jsonDecodingError(error: Error)
}

// NetworkSevice (+ Combine)
final class NetworkService {
    
    // URLSession 초기값이 없는 프로퍼티
    let session: URLSession
    
    // URLSessionConfiguration (초기화)
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
//    // Decoding
//    func fetchAppStoreInfo(payment: String, limit: Int) -> AnyPublisher<Feed, Error> {
//        
//        // url
//        let urlString: String = "https://itunes.apple.com/kr/rss/\(payment)/limit=\(limit)/json"
//        let url = URL(string: urlString)!
//        
//        return session
//            .dataTaskPublisher(for: url)
//            .tryMap { result -> Data in
//                guard let response = result.response as? HTTPURLResponse,
//                      (200..<300).contains(response.statusCode)
//            }
//    }
}

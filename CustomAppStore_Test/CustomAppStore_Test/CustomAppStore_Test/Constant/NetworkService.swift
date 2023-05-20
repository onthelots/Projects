//
//  NetworkService.swift
//  CustomAppStore_Test
//
//  Created by Jae hyuk Yim on 2023/05/20.
//

import Foundation

// MARK: - Error 타입
enum NetworkError: Error {
  case invalidRequest
  case transportError(Error)
  case responseError(statusCode: Int)
  case noData
  case decodingError(Error)
}


// MARK: - Fetch method를 활용한 API Parsing 및 Decoding
// NetworkServerirce 클래스 모델을 생성한 후, fetch method 내부에서 task 업무를 담당함

final class NetworkService {
    
    // Singleton
    static let shared = NetworkService(configure: .default)
    
    let session: URLSession
    
    init(configure: URLSessionConfiguration) {
        self.session = URLSession(configuration: configure)
    }
    
    func fetchAppInfomation(category: String, limit: Int, completion : @escaping (Result<Apps, Error>) -> Void) {
        
        let url = URL(string: "https://itunes.apple.com/search?media=software&entity=software&term=\(category)&country=kr&lang=ko_kr&limit=\(limit)")!
        
        let task = session.dataTask(with: url) { data, response, error in
        
            
            // Error -> @escaping closure 활용
            // completion 매개변수를 가지는 .
            if let error = error {
                completion(.failure(NetworkError.transportError(error)))
                return
            }
            
            // Response
            if let httpResponse = response as? HTTPURLResponse,
               !(200..<300).contains(httpResponse.statusCode) {
                completion(.failure(NetworkError.responseError(statusCode: httpResponse.statusCode)))
                return
            }
            
            // data
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            // Decoding
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601 // 날짜 타입 설정
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let apps = try decoder.decode(Apps.self, from: data)
                completion(.success(apps))
            } catch let error {
                completion(.failure(NetworkError.decodingError(error)))
            }
        }
        task.resume()
    }
}

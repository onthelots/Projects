//
//  APICaller.swift
//  Spotify_App
//
//  Created by Jae hyuk Yim on 2023/06/29.
//

import Foundation

// TODO: - Profile (Auth를 통해 사용자 인증을 마친 후 -> 관련된 정보를 불러오는 작업)

final class APICaller {
    static let shared = APICaller()
    
    private init() {}
    
    // 기본 API URL
    struct Constants {
        static let baseAPIURL = "https://api.spotify.com/v1"
    }
    
    // 사용자 정의 Error
    enum APIError: Error {
        case failedToGetData
    }
    
    
    // MARK: - UserProfile을 API 호출을 통해 가져오기
    public func getCurrentUserProfile(completion: @escaping (Result<UserProfile, Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/me"),
                      type: .GET) { baseRequest in
            
            let task = URLSession.shared.dataTask(with: baseRequest) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    // 왜 JSONSerialization을 사용하는 것인가? -> 아직 UserProfile 모델이 결정되지 않아서일듯
                    let result = try JSONSerialization.jsonObject(with: data,
                                                                  options: .fragmentsAllowed)
                    print(result)
                } catch {
                    completion(.failure(error))
                    print(error)
                }
                
            }
        }
    }
    
    // MARK: - Private
    
    /// HTTP METHOD
    enum HTTPMethod: String {
        case GET
        case POST
    }
    
    
    private func createRequest(with url: URL?,
                               type: HTTPMethod,
                               completion: @escaping (URLRequest) -> Void) {
        /// Supplies valid token to be used API Callers
        AuthManager.shared.withValidToken { token in
            guard let apiURL = url else {
                return
            }
            
            // API URL을 통해 요청을 보내기 위해선, 아래와 같은 setValue가 필요함(Header는 Authorization)
            var request = URLRequest(url: apiURL)
            request.setValue("Bearer \(token)",
                             forHTTPHeaderField: "Authorization")
            
            // HTTP Method
            request.httpMethod = type.rawValue
            request.timeoutInterval = 30
            completion(request)
        }
    }
}

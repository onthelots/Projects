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
// URLSession을 통한 네트워크 통신을 위해서 아래와 같은 순서로 작업을 실시함
/*
 ❶ Session configuration을 설정
 ❷ Session을 생성
 ❸ 통신할 URL과 Request 객체를 설정
 ❹ Task를 설정, 그에 맞는 Completion Handler 혹은 Delegate 메서드를 작성
 ❺ Task를 실행 -> Completion Handler 실행
 */

final class NetworkService {
    
    // ❷ URLSession 특정 URL에서 데이터를 다운로드, 혹은 업로드 하기 위한 API(Network <-> App)
    let session: URLSession
    
    // ❶ URLConfiguaration(URLSession을 생성하기 위한 구성요소를 정의)
    // 정책에 따라 default(기본 통신방식), ephemeral(쿠키나 캐시를 저장하지 않는 방식), background(앱이 백그라운드에 있는 상황에서의 컨텐츠 다운, 업로드)로 구분됨
    init(configuration: URLSessionConfiguration) {
        session = URLSession(configuration: configuration)
    }
    
    // ❸ load -> Data (Resource 타입에 맞는 Request 객체 설정)
    func load<T>(_ resource: Resource<T>) -> AnyPublisher<T, Error> {
        
        // URLRequest -> Resource 타입의 urlRequest(내부 연산 프로퍼티)인지 아닌지 확인
        guard let request = resource.urlRequest else {
            return .fail(NetworkError.invalidRequest)
        }
        
        // URLSession.dataTaskPublisher
        // URL 혹은 URLRequest로부터 받아온 데이터를 Publisher화 하기 위한 Combine
        // 성공할 경우, data와 URLResponse로 이루어진 튜플을 반환하며
        // 실패할 경우 Error를 발생시킴
        return session
            // publisher 생성 (request)
            .dataTaskPublisher(for: request)
            // ErrorHandling을 위해 tryMap을 활용함
            .tryMap { result -> Data in
                guard let response = result.response as? HTTPURLResponse,
                      (200..<300).contains(response.statusCode)
                else {
                    // Error
                    let response = result.response as? HTTPURLResponse
                    let statusCode = response?.statusCode ?? -1
                    throw NetworkError.responseError(statusCode: statusCode)
                }
                
                // result의 data를 반환
                return result.data
            }
            // decode를 통해 Json 데이터를 제너릭<T> 타입으로 변환할 수 있음
            .decode(type: T.self, decoder: JSONDecoder())
        
            // Subscriber가 Publisher의 너무 길어진 타입형태 및 데이터 파이프라인을 모두 알 필요가 없음
            // 따라서, Operation(tryMap)에서는 해당 데이터 파이프 라인을 확인해야 하나, subscriber에 전달할 땐 필요가 없음
            // 그래서 eraseToAnyPbulisher 수정자를 할당해줌
            .eraseToAnyPublisher()
    }
}

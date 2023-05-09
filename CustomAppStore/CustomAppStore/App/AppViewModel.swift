//
//  AppViewModel.swift
//  CustomAppStore
//
//  Created by Jae hyuk Yim on 2023/05/03.
//

import Foundation
import Combine

final class AppViewModel {
    
    // MARK: - Data Input
    // Data는 네트워크(서비스), Model의 빈 객체로서 전달할 예정임
    
    // ❶ 네트워크(Network) 담당객체
    let network: NetworkService
    
    // ❷ Model 퍼블리셔
    @Published var items: [Feed] = []
    
    // MARK: - User Interaction OupPut
    
    
    // MARK: - Subscripiton
    var subscriptions = Set<AnyCancellable>()
    
    // init
    init(network: NetworkService) {
        self.network = network
    }
    
    // fetch (Input 퍼블리셔에 각각의 데이터 할당하기)
    func fetch() {
        
        /// https://itunes.apple.com/kr/rss/topfreeapplications/limit=2/json
        // 👆🏻 먼저, NetworkService(URLSession을 활용한 API 작업)을 진행하기 위해, Resource(JSON 형식으로 데이터가 담겨 있는 URL의 정보 혹은 리소스)를 선언해야 함
        let resource: Resource<[Feed]> = Resource(
            base: "https://itunes.apple.com/",
            path: "kr/rss/topfreeapplications/limit=5/json",
            params: [:],
            header: ["Content-Type": "application/json"]
        )
        
        // networkService를 활용, resource(데이터)를 Combine 형식을 통해 불러옴(load)
        network.load(resource)
            .receive(on: RunLoop.main) // Main Thread
            .sink { completion in
                switch completion {
                case .failure(let error) :
                    print("Error : \(error)")
                case .finished :
                    print("Finished")
                }
            } receiveValue: { items in
                self.items = items // feeds 퍼블리셔에 할당
            }.store(in: &subscriptions)
    }
}

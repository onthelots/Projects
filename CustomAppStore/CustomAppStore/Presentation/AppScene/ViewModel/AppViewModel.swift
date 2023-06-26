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
    
    // ❷ Model 퍼블리셔 -> Apps 구조체 내부의 apps -> 즉 AppInfo 타입의 구조체
//    @Published var apps: [AppInfo] = []
    
    //❷ Model 퍼블리셔 -> Section별로 AppInfo 타입의 구조체를 받아오기 위해, 딕셔너리 형태로 선언함 (여기서 Terms 타입의 키에 따라 AppInfo 데이터가 달라지겠지)
    @Published var appsBySection: [Terms: [AppInfo]] = [:]
    // MARK: - User Interaction OupPut
    
    // MARK: - Subscripiton
    var subscriptions = Set<AnyCancellable>()
    
    // init
    init(network: NetworkService) {
        self.network = network
    }
    
    // fetch (Input 퍼블리셔에 각각의 데이터 할당하기)
    func fetch(term: Terms) {
        
        // 👆🏻 먼저, NetworkService(URLSession을 활용한 API 작업)을 진행하기 위해, Resource(JSON 형식으로 데이터가 담겨 있는 URL의 정보 혹은 리소스)를 선언해야 함
        let resource: Resource<Apps> = Resource(
            base: "https://itunes.apple.com",
            path: "/search",
            params: [
                "media": "software",
                "entity": "software",
                "term": term.rawValue,
                "country": "kr",
                "lang": "ko_kr",
                "limit": "3"
            ],
            header: [:] 
        )
        
        // networkService를 활용, resource(데이터)를 Combine 형식을 통해 불러옴(load)
        network.load(resource)
        // TODO: - RunLoop.main과 DispatchQueue.main.async와의 차이는 무엇일까?
            .receive(on: RunLoop.main) // Main Thread
            .sink { completion in
                switch completion {
                case .failure(let error) :
                    print("Error : \(error)")
                case .finished :
                    print("Finished")
                }
            } receiveValue: { apps in
                
                // updateAppsBySection의 매개변수로 할당될 [AppInfo]값과 term 매개변수 값을 할당함
                self.updateAppsBySection(apps.apps, for: term)
            }.store(in: &subscriptions) // Subscripiton
    }
    
    // Section에 따라 receiveValue를 할당해주는 메서드
    private func updateAppsBySection(_ apps: [AppInfo], for section: Terms) {
        // appsBySection은 딕셔너리 타입이므로, key인 section에 서로 다른 apps(AppInfo)를 할당함
        appsBySection[section] = apps
    }
}

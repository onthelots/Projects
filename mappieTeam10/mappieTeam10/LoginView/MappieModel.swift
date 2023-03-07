//
//  MappieModel.swift
//  mappieTeam10
//
//  Created by zooey on 2022/11/08.
//

import Foundation

class MappieModel: ObservableObject {
    
    @Published var loginData: [LoginData] = [
        LoginData(email: "mappie@naver.com", userName: "까치", realName: "맵피", password: "mappie")
    ] {
        didSet {
            saveItems()
        }
    }
    
    @Published var isLogged: Bool = UserDefaults.standard.bool(forKey: "isLogged") {
        didSet {
            UserDefaults.standard.set(self.isLogged, forKey: "isLogged")
        }
    }
    
    @Published var showLogin = false
    let defaults = UserDefaults.standard
   
    let itemsKey: String = "items_list"
    
   init() {
        getItems()
    }
    
    // login data 가져오기
    func getItems() {
        guard let data = UserDefaults.standard.data(forKey: itemsKey),
              let savedItems = try? JSONDecoder().decode([LoginData].self, from: data)
        else { return }
        
        self.loginData = savedItems
        print("데이터 가져오기")
    }
    
    // login data json으로 변환
    func saveItems() {
        if let encodeData = try? JSONEncoder().encode(loginData) {
            UserDefaults.standard.set(encodeData, forKey: itemsKey)
            print("데이터 저장 및 새로고침")
        }
    }
    
    // login data 생성
    func addItem(userEmail: String, userName: String, realName: String, password: String) {
        let newItem = LoginData(email: userEmail, userName: userName, realName: realName, password: password)
        loginData.append(newItem)
        print(userEmail,userName,realName,password)
        print("데이터 생성")
    } 
}



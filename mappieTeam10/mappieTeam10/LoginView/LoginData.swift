//
//  LoginData.swift
//  mappieTeam10
//
//  Created by zooey on 2022/11/08.
//

import Foundation

struct LoginData: Identifiable, Codable {
    
    let id: String
    let email: String
    let userName: String
    let realName: String
    let password: String

   
    init(id: String = UUID().uuidString, email: String, userName: String, realName: String, password: String) {
        self.id = id
        self.email = email
        self.userName = userName
        self.realName = realName
        self.password = password
    }
}

//
//  Struct Category.swift
//  mappieTeam10
//
//  Created by Jae hyuk Yim on 2022/11/08.
//

import Foundation


struct Category: Codable, Identifiable {
    
    var id: String
    var userName: String
    var category: String
    var title: String
    var contents: String
    var date: String
    var coordinates: Coordinates
    
}


struct Coordinates: Codable {
    let longitude, latitude: Double
}

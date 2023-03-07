//
//  CategoryStore.swift
//  mappieTeam10
//
//  Created by Jae hyuk Yim on 2022/11/08.
//

import Foundation


class CategoryStore: ObservableObject {
    
    @Published var category: [Category]
    
    
    
    init(category: [Category] = []) {
        self.category = category
    }
}

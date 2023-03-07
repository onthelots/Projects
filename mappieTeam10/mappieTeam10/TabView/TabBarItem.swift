//
//  TabBarItem.swift
//  mappieTeam10
//
//  Created by zooey on 2022/11/08.
//

import Foundation
import SwiftUI

enum TabBarItem: Hashable {
    
case maphome, categoryhome, settinghome
    
    var iconName: String {
        switch self {
        case .maphome: return "map.circle.fill"
        case .categoryhome: return "bubble.right.circle.fill"
        case .settinghome: return "gear.circle.fill"
        }
    }
    
    var title: String {
        switch self {
        case .maphome: return "지도"
        case .categoryhome: return "커뮤니티"
        case .settinghome: return "설정"
        }
    }
    
    var color: Color {
        switch self {
        case .maphome: return Color(red: 17/255, green: 45/255, blue: 78/255)
        case .categoryhome: return Color(red: 17/255, green: 45/255, blue: 78/255)
        case .settinghome: return Color(red: 17/255, green: 45/255, blue: 78/255)
        }
    }
    
    var background: Color {
        switch self {
        case .maphome: return Color(red: 219/255, green: 226/255, blue: 269/255)
        case .categoryhome: return Color(red: 219/255, green: 226/255, blue: 269/255)
        case .settinghome: return Color(red: 219/255, green: 226/255, blue: 269/255)
        }
    }
}




//
//  ContentView.swift
//  mappieTeam10
//
//  Created by Jae hyuk Yim on 2022/11/08.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var mappieModel: MappieModel
    //@State private var selection: String = "home"
    @State private var tabSelection: TabBarItem = .maphome    
    @AppStorage("loginUser") var loginUser: Bool = true
    @ObservedObject var categoryStore: CategoryStore = CategoryStore(category: categoryData)
    var body: some View {
        
        Group {
//            if UserDefaults.standard.string(forKey: "loginUser") == nil {
//                LogInView(mappieModel: mappieModel)
//
//            } else {
                mainInterfaceView
//            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView(mappieModel: MappieModel())
    }
}

extension ContentView {
    var mainInterfaceView: some View {
        
        CustomTabBarContainerView(selection: $tabSelection) {
            MapView(categoryStore: categoryStore)
                .tabBarItem(tab: .maphome, selection: $tabSelection)
            
            CategoryView()
                .tabBarItem(tab: .categoryhome, selection: $tabSelection)
            
            SettingView()
                .tabBarItem(tab: .settinghome, selection: $tabSelection)
            
        }
        .navigationBarBackButtonHidden(true)
    }
}


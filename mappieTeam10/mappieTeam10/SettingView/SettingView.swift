//
//  SettingView.swift
//  mappieTeam10
//
//  Created by Jae hyuk Yim on 2022/11/08.
//

import SwiftUI

struct SettingList: Identifiable {
    var id = UUID()
    var task: String
    var imageName: String
}

var listData: [SettingList] = [
    SettingList(task: "사용자 설정", imageName: "person"),
    SettingList(task: "완료된 게시글", imageName: "checkmark")
]

struct SettingView: View {
    
    
 
    
    var body: some View {
        ZStack {
            Color(red: 219/255, green: 226/255, blue: 239/255)
                .ignoresSafeArea()
            
            List {
                ForEach(listData) { item in
                    HStack {
                        Image(systemName: item.imageName)
                        Text(item.task)
                    }
                }
            }
            .background(Color(red: 219/255, green: 226/255, blue: 239/255))
            .scrollContentBackground(.hidden)
            .offset(y: 98)
            .frame(height: 600)
            .ignoresSafeArea()
            
        VStack {
                ZStack(alignment: .bottomLeading) {
                    Color(red: 63/255, green: 114/255, blue: 175/255)
                        .ignoresSafeArea()
                    
                    ZStack {
                        Circle()
                            .foregroundColor(Color(red: 249/255, green: 247/255, blue: 247/255))
                        
                        Image("mappie")
                            .resizable()
                            .frame(width: 90, height: 90)
                    }
                        .frame(width: 90, height: 90)
                        .offset(x: 29, y: 39)
                    
                    
                    
                }
                .frame(height: 150)
                
                Spacer()
            
            
            
           
            
            }
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}

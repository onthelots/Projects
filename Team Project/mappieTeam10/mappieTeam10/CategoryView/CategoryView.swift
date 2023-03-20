//
//  CategoryView.swift
//  mappieTeam10
//
//  Created by Jae hyuk Yim on 2022/11/08.
//

import SwiftUI

struct CategoryView: View {
    
    // Data, JSON 받아오기
    @ObservedObject var categoryStore: CategoryStore = CategoryStore(category: categoryData)
    
    var body: some View {
        // List 형식의 NavigationView
        //View-> Stack 으로 바꾸니까 아래로 접기?모양 없어짐
        NavigationStack {
//            VStack {
            
                HStack {
                    Button("실시간") {}
                        .buttonStyle(.bordered)
                    Button("사건/사고") {}
                        .buttonStyle(.bordered)
                    Button("분실") {}
                        .buttonStyle(.bordered)
                    Button("동네생활") {}
                        .buttonStyle(.bordered)
                    Button("반려동물") {}
                        .buttonStyle(.bordered)

                }.font(.system(size: 15))

                List {
                    ForEach(categoryStore.category) { category in
                        Section {
                            ListCell(categoryList: category)
                        }
                    }
                    
                } // List
                .listStyle(.plain)
                .navigationTitle("커뮤니티")
                .navigationBarItems(leading: NavigationLink(destination: AddWriteView(categoryStore: categoryStore)) {
                    Text("글쓰기")
                })
//            } // VStack
            
        }
        
    } //body
    
} // CategoryView
    





struct ListCell: View {
    
    var categoryList: Category
    
    var body: some View {
        
        NavigationLink(destination: CategoryDetail(categoryDetail: categoryList)) {
            
            VStack {
                VStack(alignment: .leading) {
                    Text(categoryList.category)
                        .foregroundColor(.white)
                        .background(Color.gray)
                        .cornerRadius(4)
                    Text(categoryList.title)
                        .bold()
                        .padding(.bottom, 0.5)
                    Text(categoryList.contents)
                        .lineLimit(1)
                }
            }
        }
    }
}
    

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView()
    }
}

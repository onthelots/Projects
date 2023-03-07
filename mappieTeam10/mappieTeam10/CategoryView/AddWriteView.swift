//
//  AddWriteView.swift
//  mappieTeam10
//
//  Created by Jae hyuk Yim on 2022/11/08.
//

import SwiftUI


enum CategorySort: String, CaseIterable, Identifiable {
    case 실시간, 사건사고, 분실, 동네생활, 반려동물
    var id: Self { self }
}




struct AddWriteView: View {
        
    @ObservedObject var categoryStore: CategoryStore
    @State private var selectedCategory: CategorySort = .사건사고
    
    @State var category: String = ""
    @State var name: String = ""
    
    // 날짜 자동으로 등록되는 기록
    @State var date: String = ""
    
    @State var title = ""
    @State var contents = ""
    
    // 이미지 삽입
    // MapView에서 사용자가 LongPress를 하면, 해당 위치의 좌표가 자동으로 저장?!
    @State var cordinates: Coordinates = Coordinates(longitude: 0.0, latitude: 0.0)
    
    var body: some View {
        
        
        // ??! List
        Form {
            Section(header: Text("Write")) {
                Picker("Category", selection: $selectedCategory) {
                    Text("실시간").tag(CategorySort.실시간)
                    Text("사건사고").tag(CategorySort.사건사고)
                    Text("분실").tag(CategorySort
                        .분실)
                    Text("동네생활").tag(CategorySort
                        .동네생활)
                    Text("반려동물").tag(CategorySort
                        .반려동물)
                    
                }
                DataInput(title: "제목", userInput: $title)
                DataInput(title: "내용", userInput: $contents)
                
                Button(action: addNewContents) {
                    Text("완료")
                    
                } // Button
                
                
                
            } //body
        }
    }
    
    // 새로운 게시물이 NewContents에 저장되는 함수
    func addNewContents () {
        let NewContents = Category(id: UUID().uuidString, userName: name, category: selectedCategory.rawValue, title: title, contents: contents, date: "2022-11-08", coordinates: cordinates)
        
        categoryStore.category.append(NewContents)
        
        // 완료 버튼을 누르면, CategoryView() 화면으로 이동할 수 있는 기능 추가
        
    }
}
                          

                          

                          
                          
                          
// 글 입력 구조체 DataInput
struct DataInput: View {
    
    var title: String
    
    @Binding var userInput: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
            TextField("\(title)을 입력해 주세요", text :$userInput)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }
    
}










struct AddWriteView_Previews: PreviewProvider {
    static var previews: some View {
        AddWriteView(categoryStore: CategoryStore(category: categoryData))
    }
}

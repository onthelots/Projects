//
//  InputView.swift
//  mappieTeam10
//
//  Created by 지정훈 on 2022/11/09.
//

import SwiftUI


import SwiftUI

struct InputView :View{
    
    //급하게 하느라 이름을 대충 지었습니다 ㅎㅎ 죄송함돠 
    @State var latitude: String = ""
    @State var longitude: String = ""
    @State var name: String = ""
    @State var title = ""
    @State var contents = ""
    
    @Binding var testViewMapViewVisible : Bool
    
    func sendData(){
        //데이터를 보낼 코드
        // UserDefaults 사용 예정?
    }

    var body: some View {
        
        // 정말 간단하게 구현 해봄 ListNavDemo 에서 거의 복사해서 가져왔습니다 ㅋㅋ
        Form{
            Spacer()
            Section(header: Text("Input Data")){
                VStack{
                    
                    HStack{
                        TextField("Input latitude", text: $latitude)
                        TextField("Input longitude", text: $longitude)
                    }
                    TextField("Input title", text: $title)
                        .font(.headline)
                    TextField("Input name", text: $name)
                    TextField("Input content", text: $contents)
                }
            }
            //데이터 보내기 버튼 누름으로써 데이터도 보내고, 맵뷰를 다시 보여주는 코드!
            Button {
                sendData()
                testViewMapViewVisible = true
            } label: {
                Text("데이터 보내기")
            }
            
        }
        

    }
}

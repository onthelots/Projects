//
//  RegistrationView.swift
//  mappieTeam10
//
//  Created by zooey on 2022/11/08.
//

import SwiftUI

struct RegistrationView: View {
    
    @State private var email = ""
    @State private var usernmae = ""
    @State private var fullname = ""
    @State private var password = ""
    @ObservedObject var mappieModel: MappieModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        ZStack{
            Color(red: 219/255, green: 226/255, blue: 239/255)
                .ignoresSafeArea()
            
            VStack {
                VStack(alignment: .leading) {
                    HStack { Spacer() }
                    HStack{
                        Text("Mappie")
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                        Image("mappie")
                            .resizable()
                            .frame(width: 50,height: 50)
                    }
                    Text("이웃과 함께 좋은 동네 만들기")
                        .font(.title2)
                        .fontWeight(.semibold)
                }
                .frame(height: 260)
                .padding(.leading)
                .background(Color(red: 63/255, green: 114/255, blue: 175/255))
                .foregroundColor(Color(red: 249/255, green: 247/255, blue: 247/255))
                .clipShape(RoundedShape(corners: [.bottomRight]))
                
                VStack(spacing: 40) {
                    CustomInputField(imageName: "envelope",
                                     placeholderText: "이메일",
                                     text: $email)
                    
                    CustomInputField(imageName: "person",
                                     placeholderText: "닉네임",
                                     text: $usernmae)
                    
                    CustomInputField(imageName: "person",
                                     placeholderText: "이름",
                                     text: $fullname)
                    
                    CustomInputField(imageName: "lock",
                                     placeholderText: "비밀번호",
                                     text: $password)
                }
                .padding(32)
                
                Button  {
                    saveButtonPressed()
                } label: {
                    Text("가입하기")
                        .font(.headline)
                        .foregroundColor(Color(red: 219/255, green: 226/255, blue: 239/255))
                        .frame(width: 340, height: 50)
                        .background(Color(red: 17/255, green: 45/255, blue: 78/255))
                        .cornerRadius(10)
                        .padding()
                }
                .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 0)
                
                Spacer()
                
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    HStack {
                        Text("이미 계정이 있으십니까?")
                            .font(.footnote)
                        Text("로그인하러 가기")
                            .font(.footnote)
                            .fontWeight(.semibold)
                    }
                }
                .padding(.bottom, 32)
                .foregroundColor(Color(red: 17/255, green: 45/255, blue: 78/255))
                
            }
            .ignoresSafeArea()
        }
    }
    func saveButtonPressed() {
        mappieModel.addItem(userEmail: email, userName: usernmae, realName: fullname, password: password)
        //2print(email, usernmae, fullname, password)
        presentationMode.wrappedValue.dismiss()
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView(mappieModel: MappieModel())
    }
}

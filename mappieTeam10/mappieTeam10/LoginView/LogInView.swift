//
//  logInView.swift
//  mappieTeam10
//
//  Created by Jae hyuk Yim on 2022/11/08.
//

import SwiftUI

struct LogInView: View {
    
    @State private var email = ""
    @State private var password = ""
    @ObservedObject var mappieModel: MappieModel
 
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
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
                        CustomInputField(imageName: "envelope", placeholderText: "이메일", text: $email).textCase(.lowercase)
                        
                        
                        CustomInputField(imageName: "lock", placeholderText: "비밀번호", text: $password).textCase(.lowercase)
                    }
                    .padding(.horizontal, 32)
                    .padding(.top, 44)
                    
                    HStack {
                        Spacer()
                        
                        NavigationLink(destination: RegistrationView(mappieModel: mappieModel)) {
                            Text("비밀번호를 잊어버리셨습니까?")
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundColor(Color(red: 17/255, green: 45/255, blue: 78/255))
                                .padding(.top)
                                .padding(.trailing, 24)
                        }
                    }
                    NavigationLink(destination: ContentView(mappieModel: MappieModel())) {
//                        Button  {
//                            ContentView(mappieModel: MappieModel())
//                            pressedButton(userEmail: email, userPassword: password)
//                        } label: {
                            Text("로그인")
                                .font(.headline)
                                .foregroundColor(Color(red: 219/255, green: 226/255, blue: 239/255))
                                .frame(width: 340, height: 50)
                                .background(Color(red: 17/255, green: 45/255, blue: 78/255))
                                .cornerRadius(10)
                                .padding()
//                        }
                        .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 0)
                    }
                    
                    
                    Spacer()
                    
                    NavigationLink {
                        RegistrationView(mappieModel: mappieModel)
                            .navigationBarHidden(true)
                    } label: {
                        HStack {
                            Text("계정이 없으십니까?")
                                .font(.footnote)
                            Text("회원 가입")
                                .font(.footnote)
                                .fontWeight(.semibold)
                        }
                    }
                    .padding(.bottom, 32)
                    .foregroundColor(Color(red: 17/255, green: 45/255, blue: 78/255))
                }
                .ignoresSafeArea()
                .navigationBarHidden(true)
            }
        }
    }
//    func pressedButton(userEmail: String, userPassword: String) {
//        
//        if email == userEmail && password == userPassword {
//            print(email, userEmail, password, userPassword)
//            print("되랏")
//           
//            
//        } else {
//            print(email, userEmail, password, userPassword)
//            print("안댐")
//            
//        }
//    }
}




struct logInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView(mappieModel: MappieModel())
    }
}

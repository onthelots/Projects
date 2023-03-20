//
//  SplashScreenView.swift
//  mappieTeam10
//
//  Created by zooey on 2022/11/08.
//

import SwiftUI

struct SplashScreenView: View {
    
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
        
        if isActive {
            LogInView(mappieModel: MappieModel())
        } else {
            ZStack {
                Color(red: 219/255, green: 226/255, blue: 239/255)
                    .ignoresSafeArea()
                VStack {
                    VStack {
                        Image("mappie")
                            .resizable()
                            .frame(width: 250, height: 250)
                        Text("Mappie")
                            .font(.title)
                            .foregroundColor(Color(red: 17/255, green: 45/255, blue: 78/255))
                    }
                    .scaleEffect(size)
                    .opacity(opacity)
                    .onAppear {
                        withAnimation(.easeIn(duration: 1.2)) {
                            self.size = 0.9
                            self.opacity = 1.0
                        }
                    }
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}



//
//  ContentView.swift
//  WebRTC_Practice
//
//  Created by Jae hyuk Yim on 10/19/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    NavigationLink {
                        AudioView()
                    } label: {
                        Text("오디오")
                    }
                }
            }
        }
        .padding()
        .onAppear() {
            PermissionSetting.shared.requestCameraPermission()
            PermissionSetting.shared.requestMicroPhonePermission()
        }
    }
}

#Preview {
    ContentView()
}

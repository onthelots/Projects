//
//  CustomInputField.swift
//  mappieTeam10
//
//  Created by zooey on 2022/11/08.
//

import SwiftUI

struct CustomInputField: View {
    
    let imageName: String
    let placeholderText: String
    @Binding var text: String
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color(red: 17/255, green: 45/255, blue: 78/255))
                
                TextField(placeholderText, text: $text)
            }
            
            Divider()
                .background(Color(red: 17/255, green: 45/255, blue: 78/255))
        }
    }
}

struct CustomInputField_Previews: PreviewProvider {
    static var previews: some View {
        CustomInputField(imageName: "envelope", placeholderText: "Email", text: .constant(""))
    }
}

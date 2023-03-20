//
//  SwiftUIView.swift
//  mappieTeam10
//
//  Created by Jae hyuk Yim on 2022/11/08.
//

import SwiftUI

struct todolistView: View {
    
    struct TodoList: Identifiable {
        let id = UUID()
        var content: String
        var checked: Bool
    }
    
    @State var toDoString = ""
    @State private var todoLists = [TodoList]()
    
    var body: some View {
        VStack {
            Text("What to do Today?")
                .font(.title.bold())
            
            List {
                ForEach(0..<todoLists.count, id: \.self) { i in
                    HStack {
                        Button(action: {
                                toggleCheckedState(i)
                            },
                            label: {
                            Image(systemName:
                                todoLists[i].checked == true ?
                                "checkmark.square" :
                                "square")
                            }
                        )
                        
                        Text(todoLists[i].content)
                        
                        Spacer()
                        
                        Button(
                            action: {
                                deleteList(i)
                            },
                            label: {
                                Image(systemName: "trash")
                            }
                        )
                        
                    } // HStack
                    
                    
                    .buttonStyle(BorderlessButtonStyle())
                    
                }
            } // List
            
            HStack {
                Image(systemName: "square.and.pencil")
                TextField(
                    "your task",
                    text: $toDoString,
                    onCommit: {
                        appendList()
                    }
                )
            }
            .textFieldStyle(DefaultTextFieldStyle())
            .frame(width: 300, height: 50, alignment: .center)
        }
    }
    
    func appendList() {
         let inputList = TodoList(content: toDoString, checked: false)
         todoLists.append(inputList)
         toDoString = ""
     }
    
    func toggleCheckedState(_ i: Int) {
        todoLists[i].checked.toggle()
    }
    
    func deleteList(_ i: Int) {
        todoLists.remove(at: i)
    }
}

struct todolistView_Previews: PreviewProvider {
    static var previews: some View {
        todolistView()
    }
}

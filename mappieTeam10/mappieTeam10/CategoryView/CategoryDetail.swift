//
//  CategoryDetail.swift
//  mappieTeam10
//
//  Created by Jae hyuk Yim on 2022/11/08.
//

import SwiftUI


struct ReplyRecord: Identifiable {
    var id = UUID()
    var reply: String
}


struct CategoryDetail: View {
    
    
    // 댓글로 남긴 글을 저장할 replyMessage 프로퍼티 생성
    @State private var replyMessage: String = ""
    
    
    // 위 구조체로 선언된 빈 배열인 ReplayArray 타입으로 받아, 빈 배열로 나타냄
    @State private var replyRecord = [ReplyRecord]()
    
    var categoryDetail: Category
    
    var body: some View {
        
        VStack {
            List {
                Section(header: Text(categoryDetail.category)) {
                    Text(categoryDetail.userName)
                        .font(.subheadline)
                    Text(categoryDetail.date)
                }
                
                Section {
                    Text(categoryDetail.title)
                    Text(categoryDetail.contents)
                }
                
                Section {
                    Image(systemName: "photo")
                        .aspectRatio(contentMode: .fit)
                }
                
                Section {
                    // 댓글이 작성되는 List
                    List {
                            ForEach(replyRecord, id: \.id) { record in
                                Text(record.reply)
                             
                            }

                    }.frame(height: 100.0)
                }
                
            }.navigationBarTitle("커뮤니티")
            
            // 댓글을 입력하는 창
            HStack {
                Image(systemName: "square.and.pencil")
                TextField("댓글을 입력해 주세요.",
                          text: $replyMessage,
                          onCommit: { appendReply()
                })
                
            }
            .background(Color.white)
            .textFieldStyle(DefaultTextFieldStyle())
            .frame(width: 350, height: 90, alignment: .center)
            .padding(.bottom, 100)
        } // Vstack
        
    } // body
    
    // 배열에 replyMessage 값 넣기
    func appendReply() {
        let replyList = ReplyRecord(reply: replyMessage)
        replyRecord.append(replyList)
        replyMessage = ""
    }
    
    
    // 댓글 삭제
    func deleteReply(_ i: Int) {
        replyRecord.remove(at: i)
    }
    
    
}






struct CategoryDetail_Previews: PreviewProvider {
    static var previews: some View {
        CategoryDetail(categoryDetail: categoryData[0])
    }
}

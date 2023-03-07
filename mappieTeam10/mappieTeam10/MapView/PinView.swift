//
//  PinView.swift
//  mappieTeam10
//
//  Created by Park Jungwoo on 2022/11/08.
//

import SwiftUI

struct PinView: View {
    
    let category: String
    @State private var color: Color = .black
    
    // 지도 상에서 원의 색깔을 다르기 하기 위해 카테고리 별 분류를 했습니다.
    // red / blue / green / yellow -> 팀에서 정한 4가지 컬러도 좋을 거 같습니다!
    func checkPinColor() {
        switch category {
        case "사건/사고":
            color = .red
        case "분실":
            color = .blue
        case "동네생활":
            color = .green
        case "반려동물":
            color = .yellow
        default:
            print("카테고리 이름 없음")
        }
    }
    
    // 지도 상에서 원과 카테고리를 표시하기 위한 View
    var body: some View {
        ZStack {
            //원 그리기
            Circle()
                .frame(width: 100.0, height: 100.0)         // 일단 100 , 100으로 설정하였습니다.
                .foregroundColor(color)
                .opacity(0.5)
            
            Text("\(category)")                             // 카테고리 텍스트
            
        }.onAppear {
            // 정우님 작업!          https://zeddios.tistory.com/1306 <- 한번 읽어보시면 될 거 같아요 최근에 새로 생긴 기술이라네요!
            Task {
                checkPinColor()
            }

        }
    }
}

struct PinView_Previews: PreviewProvider {
    static var previews: some View {
        PinView(category: "분실")
    }
}

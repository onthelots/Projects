//
//  loadJson.swift
//  mappieTeam10
//
//  Created by Jae hyuk Yim on 2022/11/08.
//

import Foundation


var categoryData:[Category] = loadJson("MappieData.json")




func loadJson<T : Decodable>(_ filename: String) -> T {
    let data: Data
    
    // 꾸러미 -> main만 건드릴 수 있다!
    // url을 통해
    //    Bundle.main.url(
    // 확장자 -> txt 메모파일 / wav 음성파일 등
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        // carData 가 없다!
        fatalError("\(filename) is not found.")
    }
    
    
    // 아래 오류가 발생할 수도 있는데, 한번 시도는 해봄
    // load 하는 작업
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Could not load \(filename) : \(error)")
    }
    
    
    // Decorder와 Encoder : 저희 한국인, 일본말은 못들어요. 그래서 한국말로 번역

    do {
        return try JSONDecoder().decode(T.self, from: data)
    } catch {
        fatalError("Unable to parse \(filename) : \(error)")
    }
    
    // Url을 정의하고, 그것을 Data 타입으로 전환!
    // Json 파일을 Decorder
    
    // 1. Json의 친숙도가 낮다.
    // 데이터 포맷
    // xml, yam, json 등등
    // json 확장자 파일
    // 속도가 좋다!
    // 어떠한 형식 데이터 모으는..
    // JavaScript Object Notation (JSON)
    
    
    // 2. do-Catch (에러핸들링)
    // 동적이다 or 정적이다?
    // 이것은 동적이다! (실행을 하기 때문) -> 트랜드가 바뀌어서
    // 예전에는 거의 대부분 정적. 메모리와 CPU양이 낮기 때문에! 줄은 서있는데, 앞사람만 준다!
    // 사람 사고가..? 차례대로 밖에 못해요.
    // 어떠한 사건이 일어났을 때, 예외 처리가 중요하기 때문에 do catch를 사용해야 한다!

}


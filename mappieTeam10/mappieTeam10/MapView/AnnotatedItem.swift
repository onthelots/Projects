//
//  AnnotatedItem.swift
//  mappieTeam10
//
//  Created by Park Jungwoo on 2022/11/08.
//

import Foundation
import MapKit


// pinItem은 AnnotatedItem형을 가진 배열입니다
var pinItem: [AnnotatedItem] = []

// for in 문을 통해 name , coordinate 안에 JSON 파일 파싱 된 데이터 별로 들어가 배열을 구성함!
//AnnotatedItem(
//    name:" 카테고리 이름",
//    coordinate: CLLocationCoordinate2D(latitude: "37.535301", longitude: '127.130636)
//    ----------------
//    name:" 카테고리 이름",
//    coordinate: CLLocationCoordinate2D(latitude: "37.535301", longitude: '127.130636)
//    ----------------
//    name:" 카테고리 이름",
//    coordinate: CLLocationCoordinate2D(latitude: "37.535301", longitude: '127.130636)
//    ----------------
//    name:" 카테고리 이름",
//    coordinate: CLLocationCoordinate2D(latitude: "37.535301", longitude: '127.130636)
//    ----------------
//    name:" 카테고리 이름",
//    coordinate: CLLocationCoordinate2D(latitude: "37.535301", longitude: '127.130636)
//    ----------------
//    name:" 카테고리 이름",
//    coordinate: CLLocationCoordinate2D(latitude: "37.535301", longitude: '127.130636)
//
//)


struct AnnotatedItem: Identifiable {
    let id = UUID()
    var name: String
    var coordinate: CLLocationCoordinate2D
}

//
//  MapView.swift
//  mappieTeam10
//
//  Created by Jae hyuk Yim on 2022/11/08.
//

import SwiftUI
import MapKit

struct MapView: View {
    // observed 객체 -> 새롭게 받아와야함, 수정 필요
    @ObservedObject private var categoryStore: CategoryStore
    @ObservedObject private var locationManager = UserLocationManager()
    
    //지도 bool 값에 따라 보여주기 코드
    @State var mapViewVisible : Bool = true
    
    // MKCoodrinateRegion = 시작 좌표(강동역)
    // Span = 축적비 -> 테스트 해서 비율 맞춰줘야함
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.53594, longitude: 127.132187), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    
    init(categoryStore: CategoryStore) {
        self.categoryStore = categoryStore
        self.region = region
        
        // 핀 데이터 넘겨줌, 비동기 처리로 새로운 데이터가 들어올떄 기다려줌
        Task {
            for i in categoryStore.category {
                // categoryStore.category의 갯수 만큼 for in 문 돌려 pinItem이라는 객체배열에 데이터를 넣어줌! ( 카테코리 , 경도, 위도 좌표 )
                pinItem.append(
                    AnnotatedItem(
                        name: i.category, coordinate: CLLocationCoordinate2D(latitude: i.coordinates.latitude, longitude: i.coordinates.longitude))
                )
            }
        }
    }
    
    var body: some View {
        VStack {
            // 처음에는 true 값으로 맵뷰를 보여줍니다! 하지만 false 가될 경우에는 else문인 inputview를 보여줍니다!
            if(mapViewVisible){
                // 맵뷰, MapMarker - 실제로 마크를 찍어주는 영역
                Map(coordinateRegion: $region,
                    showsUserLocation: true, annotationItems: pinItem) { item in
                    MapAnnotation(coordinate: item.coordinate) {
                        // 커스텀 핀
                        PinView(category: item.name)
                    }
                    //지도를 1초? 정도 누르면 실행이 되는 제스처
                }.onLongPressGesture{
                    print("Long")
                    //맵뷰를 안보여주게 하기 위해 fasle 문으로 설정
                    mapViewVisible = false

                }.onAppear {
                    locationManager.checkIfLocationServicesIsEnabled()
                }
            }else{
                // 데이터 보내주기 view로 보여줌 -> AddWriteView로 통합해서 보여주는게 깔끔하고 좋을지도
                InputView(testViewMapViewVisible: $mapViewVisible)
            }
        }
        .onAppear {
            print("onappear")
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(categoryStore: CategoryStore())
    }
}

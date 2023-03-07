//
//  UserLocationManager.swift
//  mappieTeam10
//
//  Created by Park Jungwoo on 2022/11/09.
//

import Foundation
import MapKit

// 정우님이 작업 하신 현재 위치를 받아오는 코드 부분!
// 처음 어플을 켰을때 현재 위치를 받아오는 허락을 받음!
final class UserLocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    var locationManager: CLLocationManager?
    
    func checkIfLocationServicesIsEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager!.delegate = self
        } else {
            print("Show an alert letting them know this is off and to go turn it on.")
        }
    }
    
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager else { return }
        
        switch locationManager.authorizationStatus {
        case .notDetermined:
            // 위치권한 요청
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Your location is restricted likely due to parental controls.")
        case .denied:
            print("You have denied this app location permission. Go into setting in change it.")
        case .authorizedAlways, .authorizedWhenInUse:
            break
        @unknown default:
            break
        }
    }
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}

//
//  User+PermissionSetting.swift
//  WebRTC_Practice
//
//  Created by Jae hyuk Yim on 10/19/23.
//

import Foundation
import AVFoundation

class PermissionSetting {
    static let shared = PermissionSetting()

    private init () {}

    // MARK: - 카메라 권한 설정
    func requestCameraPermission() {
        AVCaptureDevice.requestAccess(for: .video) { isGranted in
            isGranted ? print("Camera permisson allowed") : print("Camera permission disallowed")
        }
    }

    // MARK: - 음성 권한 설정
    func requestMicroPhonePermission() {
        if #available(iOS 17.0, *) {
            AVAudioApplication.requestRecordPermission { isGranted in
                isGranted ? print("Audio permisson allowed") : print("Audio permission disallowed")
            }
        } else {
            AVAudioSession.sharedInstance().requestRecordPermission { isGranted in
                isGranted ? print("Audio permisson allowed") : print("Audio permission disallowed")
            }
        }
    }

}

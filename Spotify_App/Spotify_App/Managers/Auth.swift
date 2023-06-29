//
//  Auth.swift
//  Spotify_App
//
//  Created by Jae hyuk Yim on 2023/06/29.
//

import Foundation

final class AuthManage {
    static let shared = AuthManage()
    
    private init() {}
    
    var isSignedIn: Bool {
        return false
    }
    
    private var accessToken: String? {
        return nil
    }
    
    private var refreshToken: String? {
        return nil
    }
    
    private var tokenExpirationDate: String? {
        return nil
    }
    
    private var shouldRefreshToken: Bool {
        return false
    }
}

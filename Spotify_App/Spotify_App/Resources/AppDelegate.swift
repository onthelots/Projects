//
//  AppDelegate.swift
//  Spotify_App
//
//  Created by Jae hyuk Yim on 2023/06/29.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // Info파일에서 Storyboard를 제거했기 때문에, 빌드 시 팝업되어야 할 ViewController를 AppDelegate에서 설정해야 함
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // App이 Launch될 때, 나타나야 할 window를 -> window 임의 상수로 설정하고,
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        // AuthManager (SingIn의 여부 확인)
        
        // SignedIn이 true일 경우 -> AppDelegate 상에서 TabBarVC 창 (전체 Scene을 확인)으로
        if AuthManager.shared.isSignedIn {
            window.rootViewController = TabBarViewController()
        } else {
            // 그렇지 않다면, NavigationController에서의 WelcomeVC을 나타냄
            let navVC = UINavigationController(rootViewController: WelcomeViewController())
            navVC.navigationBar.prefersLargeTitles = true
            
            // ⁉️ Navigation controller 는 여러개의 vc를 관리하는 컨테이너 형태의 배열임(pop, push가 가능함)
            // 따라서, NavigationController의 첫번째 vc인 WelcomeVC를 나타내기 위해 .first를 사용함
            navVC.viewControllers.first?.navigationItem.largeTitleDisplayMode = .always
            window.rootViewController = UINavigationController(rootViewController: WelcomeViewController())
        }
        
        // 🟢 rootViewController (TabBar에서 가장 맨 처음 화면을 담당할 VC)
//        window.rootViewController = HomeViewController()
        window.makeKeyAndVisible()
        
        // AppDelegate의 변수 window의 값으로, 앞서 선언한 window를 할당함
        self.window = window
        
        // Auth URL이 작동이 잘 되는지 여부 확인
//        print(AuthManager.shared.signInURL?.absoluteString ?? "URL이 잘못되었습니다.")
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}


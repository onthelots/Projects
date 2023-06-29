//
//  WelcomeViewController.swift
//  Spotify_App
//
//  Created by Jae hyuk Yim on 2023/06/29.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    // signInButton
    private let signInButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Sign In with Spotify", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Spotify"
        view.backgroundColor = .systemGreen
        
        // 하위뷰로 signInButton을 추가
        view.addSubview(signInButton)
        
        // addTarget을 통해 signInButton이 클릭(TouchUpInside)되었을 때 didTapSignIn 메서드를 실행(#selector)
        signInButton.addTarget(self,
                               action: #selector(didTapSignIn),
                               for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // signInButton의 Layout 설정 (frame은 상위뷰와의 관계)
        // TODO: - Anchor를 활용하여 Constraints를 추후 리팩토링 하기
        // frame으로 잡으면 너무 어려워..
        signInButton.frame = CGRect(x: 20,
                                    y: view.height-50-view.safeAreaInsets.bottom, //768
                                    width: view.width-40,
                                    height: 50)
        
    }
    
    // [Method] SignIn을 클릭할 경우
    @objc func didTapSignIn() {
        let vc = AuthViewController()
        
        // SignIn 버튼을 누른 이후 작업해야 할 사항이며, success란 인자를 활용 -> 비동기 처리를 통해 handleSignIn 메서드를 실행시켜줌
        // handleSignIn 메서드 또한 Success란 매개변수를 가지고 있으며, 내부로직에서 true 혹은 false 작업을 비동기 적으로 실시하면
        // AuthVC로 넘어가거나, TabBarVC로 넘어가는 방식을 취함
        // [weak self] -> 순환 참조를 방지하기 위해
        vc.completionHandler = { [weak self] success in
            DispatchQueue.main.async {
                self?.handleSignIn(success: success)
            }
        }
        
        // AuthViewController의 largeTitle은 보이지 않게 하며
        vc.navigationItem.largeTitleDisplayMode = .never
        
        // AuthViewController 화면으로 이동시킴
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func handleSignIn(success: Bool) {
        // 로그인 되거나, 그렇지 않아서 오류를 보여주거나
        guard success else {
            // 실패하면 알림을 띄어주자
            let alert = UIAlertController(title: "Oops",
                                          message: "Something went wrong when signing in.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
            present(alert, animated: true)
            return
        }
        
        let mainAppTabBarVC = TabBarViewController()
        
        // 아예 뒤로(WelcomeHome) 갈 수 없도록 fullScreen의 모달형식을 띄어버림
        mainAppTabBarVC.modalPresentationStyle = .fullScreen
        
        // mainAppTabBarVC인 TabBarViewController(Core)로 이동
        present(mainAppTabBarVC, animated: true)
    }
}

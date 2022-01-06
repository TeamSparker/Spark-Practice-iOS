//
//  ViewController.swift
//  Practice-JH
//
//  Created by Junho Lee on 2022/01/05.
//

import UIKit
import KakaoSDKUser
import KakaoSDKAuth
import KakaoSDKCommon
import JJFloatingActionButton

class ViewController: UIViewController {

    @IBOutlet weak var talkLoginButton: UIButton!
    @IBOutlet weak var accountLoginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 앱 실행시마다 연결 끊기
        UserApi.shared.unlink {(error) in
            if let error = error {
                print(error)
            }
            else {
                print("unlink() success.")
            }
        }
        
        setFloatingButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 토큰을 가지고 있는지 검사하여 logoutVC에서 pop되었을 때 상태에 따라 다시 돌아가게 만듬
//        if (AuthApi.hasToken()) {
//            UserApi.shared.accessTokenInfo { (_, error) in
//                if let error = error {
//                    if let sdkError = error as? SdkError, sdkError.isInvalidTokenError() == true  {
//                        //로그인 필요
//                    }
//                    else {
//                        //기타 에러
//                    }
//                }
//                else {
//                    // 토큰 유효성 체크 성공(필요 시 토큰 갱신됨)
//                    print("토큰 유효성 체크 성공")
//
//                    // ✅ 사용자 정보를 가져오고 화면전환을 하는 커스텀 메서드
//                    self.getUserInfo()
//                }
//            }
//        }
//        else {
//            //로그인 필요
//        }
    }

    @IBAction func touchTalkLogin(_ sender: Any) {
        loginKakao()
    }
    
    @IBAction func touchAccountLogin(_ sender: Any) {
        loginKakaoAccount()
    }
}

extension ViewController {
    func loginKakao() {
        print("loginKakao() called.")
        
        // ✅ 카카오톡 설치 여부 확인
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("loginWithKakaoTalk() success.")
                    
                    // ✅ 회원가입 성공 시 oauthToken 저장가능하다
                    // _ = oauthToken
                    
                    // ✅ 사용자정보를 성공적으로 가져오면 화면전환 한다.
                    self.getUserInfo()
                }
            }
        }
        // ✅ 카카오톡 미설치
        else {
            print("카카오톡 미설치")
        }
    }
    
    private func getUserInfo() {
        
        // ✅ 사용자 정보 가져오기
        UserApi.shared.me() {(user, error) in
            if let error = error {
                print(error)
            }
            else {
                print("me() success.")
                
                // ✅ 닉네임, 이메일 정보
                let nickname = user?.kakaoAccount?.profile?.nickname
                let email = user?.kakaoAccount?.email
                let userId = user?.id
                let birthday = user?.kakaoAccount?.birthday
                let profile = user?.kakaoAccount?.profile?.profileImageUrl
                
                guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "LogoutViewController") as? LogoutViewController else { return }
                
                // ✅ 사용자 정보 넘기기
                nextVC.nickname = nickname
                nextVC.email = email
                nextVC.userId = userId
                nextVC.birthday = birthday
                nextVC.profile = profile!
                
                // ✅ 화면전환
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
        }
    }
    
    func loginKakaoAccount() {
        print("loginKakaoAccount() called.")

        // ✅ 기본 웹 브라우저를 사용하여 로그인 진행.
        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
            if let error = error {
                print(error)
            }
            else {
                print("loginWithKakaoAccount() success.")

                // ✅ 회원가입 성공 시 oauthToken 저장
                // _ = oauthToken

                // ✅ 사용자정보를 성공적으로 가져오면 화면전환 한다.
                self.getUserInfo()
            }
        }
    }
    
    func setFloatingButton(){
        let actionButton = JJFloatingActionButton()
        let spark_red_color: UIColor = UIColor(red: 1, green: 0, blue: 0.24, alpha: 1)
        
        actionButton.addItem(title: "방 만들기", image: UIImage(named: "floating_room_icon")?.withRenderingMode(.alwaysTemplate)) { item in
            // 클릭 action 부분
        }
        
        actionButton.addItem(title: "코드로 참여", image: UIImage(named: "floating_code_icon")?.withRenderingMode(.alwaysTemplate)) { item in
            // 클릭 action 부분
        }
        
        actionButton.configureDefaultItem { item in
            item.buttonColor = spark_red_color
            item.buttonImageColor = .white
        }
        
        self.view.addSubview(actionButton)
        actionButton.buttonColor = spark_red_color
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        actionButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        actionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
    }
}


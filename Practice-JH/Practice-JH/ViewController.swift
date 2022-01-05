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

class ViewController: UIViewController {

    @IBOutlet weak var talkLoginButton: UIButton!
    @IBOutlet weak var accountLoginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
                
                guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "LogoutViewController") as? LogoutViewController else { return }
                
                // ✅ 사용자 정보 넘기기
                nextVC.nickname = nickname
                nextVC.email = email
                
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
}


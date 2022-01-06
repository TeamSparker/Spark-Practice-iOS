//
//  AppDelegate.swift
//  socialLogin
//
//  Created by 양수빈 on 2022/01/05.
//

import UIKit
import AuthenticationServices

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        appleIDProvider.getCredentialState(forUserID: UserDefaults.standard.string(forKey: "setUserIdentifier") ?? "") { credentialState, error in
            switch credentialState {
            case .authorized:
                // Apple ID Credential is valid
                // 로그인된 상태 -> 홈뷰
                print("해당 ID는 연동되어 있습니다.")
            case .revoked:
                // Apple ID Credential revoked, handle unlink
                // 로그아웃된 상태 -> 로그인뷰
                print("해당 ID는 연동되어 있지 않습니다.")
            case .notFound:
                // Credential not found, show login UI
                // 잘못된 userIdentifier -> 로그인뷰
                print("해당 ID를 찾을 수 없습니다.")
            default:
                break
            }
        }
        
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


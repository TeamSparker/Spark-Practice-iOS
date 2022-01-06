//
//  ViewController.swift
//  socialLogin
//
//  Created by 양수빈 on 2022/01/05.
//

import UIKit

import AuthenticationServices
import SnapKit

class ViewController: UIViewController {
    
    let appleLoginButton = ASAuthorizationAppleIDButton(type: .continue, style: .black)
    var nameLabel = UILabel()
    var emailLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLayout()
        setUI()
    }

    func setLayout() {
        view.addSubview(appleLoginButton)
        view.addSubview(nameLabel)
        view.addSubview(emailLabel)
        
        appleLoginButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(appleLoginButton.snp.bottom).offset(30)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(nameLabel.snp.bottom).offset(20)
        }
    }
    
    func setUI() {
        nameLabel.text = "name"
        emailLabel.text = "email"
        
        appleLoginButton.addTarget(self, action: #selector(handleAuthorizationAppleIDButtonPress), for: .touchUpInside)
    }
    
    @objc
    func handleAuthorizationAppleIDButtonPress() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
}

extension ViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            
            let userIdentifier = appleIDCredential.user
            
            if let fullName = appleIDCredential.fullName,
               let email = appleIDCredential.email {
                
                let username: String = "\(fullName.familyName ?? "")" + "\(fullName.givenName ?? "")"
                
                print("fullName: \(fullName)")
                print("userName: \(username), email: \(email)")
                
                UserDefaults.standard.set(username, forKey: "setFullName")
                UserDefaults.standard.set(email, forKey: "setEmail")
            }
                
            if let fullName = appleIDCredential.fullName,
               let email = appleIDCredential.email,
               let authorizationCode = appleIDCredential.authorizationCode,
               let identityToken = appleIDCredential.identityToken,
               let authString = String(data: authorizationCode, encoding: .utf8) {
                
                print("authorizationCode: \(authorizationCode)")
                print("identityToken: \(identityToken)")
                print("authString: \(authString)")
            }
            
            print("useridentifier: \(userIdentifier)")

            nameLabel.text = UserDefaults.standard.string(forKey: "setFullName")
            emailLabel.text = UserDefaults.standard.string(forKey: "setEmail")
        
        case let passwordCredential as ASPasswordCredential:
            
            let username = passwordCredential.user
            let password = passwordCredential.password
            
            print("username: \(username), password: \(password)")
            
        default:
            break
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("login error wow")
    }
}

extension ViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}


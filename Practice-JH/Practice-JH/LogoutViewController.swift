//
//  LogoutViewController.swift
//  Practice-JH
//
//  Created by Junho Lee on 2022/01/06.
//

import UIKit
import KakaoSDKUser

class LogoutViewController: UIViewController {
    var nickname: String?
    var email: String?
    var userId: Int64?
    var birthday: String?
    var urlString = "https://archijude.tistory.com/183"
    var profile: URL?

    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var userIdLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setText()
    }
    @IBAction func logoutClicked(_ sender: Any) {
        // ✅ 로그아웃 : 로그아웃은 API 요청의 성공 여부와 관계없이 토큰을 삭제 처리한다는 점에 유의합니다.
        UserApi.shared.logout {(error) in
            if let error = error {
                print(error)
            }
            else {
                print("logout() success.")

                // ✅ 로그아웃 시 메인으로 보냄
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @IBAction func unlinkClicked(_ sender: Any) {
        // ✅ 연결 끊기 : 연결이 끊어지면 기존의 토큰은 더 이상 사용할 수 없으므로, 연결 끊기 API 요청 성공 시 로그아웃 처리가 함께 이뤄져 토큰이 삭제됩니다.
        UserApi.shared.unlink {(error) in
            if let error = error {
                print(error)
            }
            else {
                print("unlink() success.")

                // ✅ 연결끊기 시 메인으로 보냄
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}

extension LogoutViewController {
    func setText(){
        nicknameLabel.text = nickname
        emailLabel.text = email
        userIdLabel.text = "\(userId)"
        birthdayLabel.text = birthday
        
        let url = profile!
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url)
            DispatchQueue.main.async {
                self.profileImageView.image = UIImage(data: data!)
            }
        }
        
    }
}

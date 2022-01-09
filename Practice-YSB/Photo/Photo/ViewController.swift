//
//  ViewController.swift
//  Photo
//
//  Created by 양수빈 on 2022/01/08.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - @IBOutlet
    
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - Properties
    
    let picker = UIImagePickerController()
    
    // MARK: - View Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.delegate = self
    }

    // MARK: - @IBAction
    
    @IBAction func getPhotoImage(_ sender: Any) {
        /// alterController 생성
        let alter = UIAlertController(title: "사진가져오기", message: "진짜로 사진을 가져오시겠어요?", preferredStyle: .actionSheet)
        
        /// alter에 들어갈 액션 생성
        let library = UIAlertAction(title: "앨범에서 가져오기", style: .default) { action in
            self.openLibrary()
        }
        
        let camera = UIAlertAction(title: "카메라 열기", style: .default) { action in
            self.openCamera()
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        /// alter에 액션을 넣어줌
        alter.addAction(library)
        alter.addAction(camera)
        alter.addAction(cancel)
        
        /// button tap했을 때 alter present
        present(alter, animated: true, completion: nil)
    }
    
    func openLibrary() {
        /// UIImagePickerController에서 어떤 식으로 image를 pick해올지 -> 앨범에서 픽해오겠다
        picker.sourceType = .photoLibrary
        present(picker, animated: false, completion: nil)
    }
    
    func openCamera() {
        /// 카메라 촬영 타입이 가능하다면
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            /// UIImagePickerController에서 어떤 식으로 image를 pick해올지 -> 카메라 촬영헤서 픽해오겠다
            picker.sourceType = .camera
            present(picker, animated: false, completion: nil)
        } else {
            print("카메라 안됩니다.")
        }
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        print("------------------")
//        print(info)
//        print("------------------")
        /// UIImage 타입인 originalImage를 빼옴
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = image
            imageView.contentMode = .scaleAspectFill /// 1:1 로 맞춰둔 imageView에 꽉 채우겠다.
        }
        dismiss(animated: true, completion: nil)
    }
}


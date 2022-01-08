//
//  ViewController.swift
//  Photo
//
//  Created by 양수빈 on 2022/01/08.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.delegate = self
    }

    @IBAction func getPhotoImage(_ sender: Any) {
        let alter = UIAlertController(title: "사진가져오기", message: "진짜로 사진을 가져오시겠어요?", preferredStyle: .actionSheet)
        
        let library = UIAlertAction(title: "앨범에서 가져오기", style: .default) { action in
            self.openLibrary()
        }
        
        let camera = UIAlertAction(title: "카메라 열기", style: .default) { action in
            self.openCamera()
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alter.addAction(library)
        alter.addAction(camera)
        alter.addAction(cancel)
        
        present(alter, animated: true, completion: nil)
    }
    
    func openLibrary() {
        picker.sourceType = .photoLibrary
        present(picker, animated: false, completion: nil)
    }
    
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
            present(picker, animated: false, completion: nil)
        } else {
            print("카메라 안됩니다.")
        }
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = image
            imageView.contentMode = .scaleAspectFill
        }
        dismiss(animated: true, completion: nil)
    }
}


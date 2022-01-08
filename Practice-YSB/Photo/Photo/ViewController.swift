//
//  ViewController.swift
//  Photo
//
//  Created by 양수빈 on 2022/01/08.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func getPhotoImage(_ sender: Any) {
        let alter = UIAlertController(title: "사진가져오기", message: "진짜로 사진을 가져오시겠어요?", preferredStyle: .actionSheet)
        
        let library = UIAlertAction(title: "앨범에서 가져오기", style: .default) { action in
            print("앨범 선택")
        }
        
        let camera = UIAlertAction(title: "카메라 열기", style: .default) { action in
            print("카메라 선택")
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alter.addAction(library)
        alter.addAction(camera)
        alter.addAction(cancel)
        
        present(alter, animated: true, completion: nil)
    }
    
}


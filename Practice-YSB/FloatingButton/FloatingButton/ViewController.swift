//
//  ViewController.swift
//  FloatingButton
//
//  Created by 양수빈 on 2022/01/07.
//

import UIKit

import JJFloatingActionButton
import SnapKit

class ViewController: BaseViewController {
    
    // MARK: - Properties
    /// 뷰에 올릴 프로퍼티 선언
    let textLabel = UILabel()

    // MARK: - View Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// BaseViewController를 상속받기 때문에, BaseViewController에서 viewDidLoad()에 넣어둔 함수는 다시 안넣어도 적용O
    }

    // MARK: - Method
    
    override func setUI() {
        super.setUI()
        
        /// 프로퍼티 특성 설정
        textLabel.text = "Floating Button Test"
        textLabel.textColor = .white
    }
    
    override func setLayout() {
        /// 프로퍼티를 View에 넣어줌 (storyboard에서 viewcontroller에 올리는 과정)
        view.addSubview(textLabel)
        
        /// textLabel의 레이아웃 설정
        textLabel.snp.makeConstraints { make in
            /// superView를 기준으로 center에 배치
            make.center.equalToSuperview()
        }
    }
}


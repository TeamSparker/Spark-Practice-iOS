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
    let titleLabel = UILabel()
    let subTitleLabel = UILabel()
    let actionButton = JJFloatingActionButton()
    let tap = UITapGestureRecognizer()

    // MARK: - View Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// BaseViewController를 상속받기 때문에, BaseViewController에서 viewDidLoad()에 넣어둔 함수는 다시 안넣어도 적용O
        setButtonUI()
        setAddTarget()
    }

    // MARK: - Method
    
    override func setUI() {
        super.setUI()
        
        /// 프로퍼티 특성 설정
        titleLabel.text = "Floating Button Test"
        titleLabel.textColor = .white
        
        subTitleLabel.text = "화이팅"
        subTitleLabel.textColor = .gray
        
        /// gesture 지정할 요소 외의 모든 다른 부분의 touch도 받아들이도록 false 설정
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    override func setLayout() {
        /// 프로퍼티를 View에 넣어줌 (storyboard에서 viewcontroller에 올리는 과정)
        view.addSubview(titleLabel)
        view.addSubview(actionButton)
        view.addSubview(subTitleLabel)
        
        /// textLabel의 레이아웃 설정
        titleLabel.snp.makeConstraints { make in
            /// superView를 기준으로 center에 배치
            make.center.equalToSuperview()
        }
        
        subTitleLabel.snp.makeConstraints { make in
            /// subTitleLabel의 top을 titleLabel의 bottom으로부터 20만큼 띄우겠다
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.centerX.equalTo(titleLabel.snp.centerX)
        }
        
        actionButton.snp.makeConstraints { make in
            /// actionButton의 trailing과 bottom을 superView의 trailing과 bottom으로부터 각각 30씩 안쪽으로 constraint를 주겠다
            /// 두개를 아래처럼 따로 써도 되고, 같은 값이라면 합칠 수도 O
            
//            make.trailing.equalToSuperview().inset(30)
//            make.bottom.equalToSuperview().inset(30)
            
            make.trailing.bottom.equalToSuperview().inset(30)
        }
    }
    
    func setButtonUI() {
        /// 버튼 컬러
        actionButton.buttonColor = .purple
        /// 버튼 이미지
        actionButton.buttonImage = UIImage(systemName: "moon")
        /// 버튼 이미지 컬러
        actionButton.buttonImageColor = .white
        /// 버튼 이미지 크기
        actionButton.buttonImageSize = CGSize(width: 24, height: 24)
        /// 버튼 탭했을 때 순간 컬러
        actionButton.highlightedButtonColor = .orange
        /// item 버튼 크기
        actionButton.itemSizeRatio = CGFloat(1)
        /// item 버튼 추가
        actionButton.addItem(title: "첫번째", image: UIImage(systemName: "house")) { _ in
            print("첫번째 눌림")
        }
        
        actionButton.addItem(title: "두번째", image: UIImage(systemName: "house.fill")) { _ in
            print("두번째 눌림")
        }

        /// item 버튼 등장하는 방식
        actionButton.itemAnimationConfiguration = .popUp() /// default
        /// 버튼 shadow 컬러
        actionButton.layer.shadowColor = UIColor.white.cgColor
        /// 버튼 shadow 방향
        actionButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        /// 버튼 shadow 투명도
        actionButton.layer.shadowOpacity = Float(0.4)
        /// 버튼 shadow 퍼지는 정도
        actionButton.layer.shadowRadius = CGFloat(10)
    }
    
    func setAddTarget() {
        actionButton.addTarget(self, action: #selector(setButtonColor), for: .touchUpInside)
        tap.addTarget(self, action: #selector(setButtonColor))
    }
    
    /// actionButton을 클릭했을 때, buttonState.rawValue 값에 따라 버튼 컬러 재설정 시도
    @objc
    func setButtonColor() {
        /// buttonState == 2 -> 플로팅 버튼 안펼쳐진 상태
        if actionButton.buttonState.rawValue == 2 {
            actionButton.buttonColor = .red
        } else {
            actionButton.buttonColor = .purple
        }
    }
}


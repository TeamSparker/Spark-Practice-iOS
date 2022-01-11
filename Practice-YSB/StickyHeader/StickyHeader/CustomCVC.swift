//
//  CustomCVC.swift
//  StickyHeader
//
//  Created by 양수빈 on 2022/01/10.
//

import UIKit

import SnapKit

class CustomCVC: UICollectionViewCell {
    static let identifier = "CustomCVC"
    
    // MARK: - Properties
    let titleLabel = UILabel()
    let userNameLabel = UILabel()
    
    // MARK: - View Life Cycles
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = "---"
        userNameLabel.text = "사용자이름"
    }
    
    // MARK: - Methods
    func setUI() {
        titleLabel.text = "---"
        userNameLabel.text = "사용자이름"
        
        titleLabel.font = .systemFont(ofSize: 20)
        userNameLabel.font = .systemFont(ofSize: 14)
        userNameLabel.textColor = .gray
    }
    
    func setLayout() {
        addSubview(titleLabel)
        addSubview(userNameLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(16)
        }
        
        userNameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
        }
    }
}

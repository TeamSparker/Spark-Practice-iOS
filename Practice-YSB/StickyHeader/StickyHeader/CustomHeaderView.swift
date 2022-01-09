//
//  CustomHeaderView.swift
//  StickyHeader
//
//  Created by 양수빈 on 2022/01/10.
//

import UIKit

import SnapKit

class CustomHeaderView: UICollectionReusableView {
    
    static let identifier = "CustomHeaderView"
    
    let textLabel = UILabel()
    
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
        
        textLabel.text = ""
    }
    
    func setUI() {
        textLabel.text = "Header"
        self.backgroundColor = .yellow
    }
    
    func setLayout() {
        addSubview(textLabel)
        
        textLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
        }
    }
        
}

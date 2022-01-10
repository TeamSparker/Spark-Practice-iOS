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
    
    // MARK: - Properties
    let dateLabel = UILabel()
    
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
        
        dateLabel.text = ""
    }
    
    // MARK: - Methods
    func setUI() {
        dateLabel.text = "Header"
        dateLabel.font = .systemFont(ofSize: 30)
    }
    
    func setLayout() {
        addSubview(dateLabel)
        
        dateLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
    }
        
}

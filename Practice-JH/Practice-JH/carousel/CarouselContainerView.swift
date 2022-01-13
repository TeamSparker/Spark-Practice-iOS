//
//  CarouselContainerView.swift
//  Practice-JH
//
//  Created by Junho Lee on 2022/01/11.
//

import UIKit
import SnapKit

class CarouselContainerView: UIView {
    
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        let cv = UICollectionView(frame: CGRect(x: 0,y: 0,width: 0,height: 0), collectionViewLayout: layout)
        
        var cvIdentifier = "CVC"
        
        return cv
    }()
    
    public var identifier = "View"
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    init(putIdentifier: String) {
        super.init(frame: .zero)
        self.backgroundColor = .red
        self.layer.name = "firstView"
        
        addSubview(collectionView)
//        collectionView.iden
        
        self.collectionView.snp.makeConstraints { make in
            make.edges.equalTo(self).inset(10)
        }
        identifier = putIdentifier
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        self.backgroundColor = .red
//
//        addSubview(collectionView)
//
//        self.collectionView.snp.makeConstraints { make in
//            make.width.height.equalTo(self)
//        }
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
}

class MyButton: UIButton {
    public var statusCV: Int?
}

//extension UIView {
//    let cellCase :carouselCase = [.firstView, .secondView, .thirdView]
//}

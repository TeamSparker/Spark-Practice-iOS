//
//  CarouselVC.swift
//  Practice-JH
//
//  Created by Junho Lee on 2022/01/07.
//

import UIKit
import SnapKit

enum carouselCase{
    case firstView
    case secondView
    case thirdView
}

class CarouselVC: UIViewController {
    
    @IBOutlet weak var carouselCV: UICollectionView!
    private var isClicked: Bool = false

    let firstViewButton = MyButton()
    let secondViewButton = MyButton()
    let thirdViewButton = MyButton()
    var selectedItem = 3
    
    
    let firstView = CarouselContainerView(putIdentifier: "firstView")
    let secondView = CarouselContainerView(putIdentifier: "secondView")
    let thirdView = CarouselContainerView(putIdentifier: "thirdView")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        addCollectionView(isClicked)
        setDelegate()
//        carouselCV.backgroundColor = .clear
        self.view.backgroundColor = .white
        
        addSubviewss(firstViewButton, secondViewButton, thirdViewButton)
        
        //버튼 관련
        setButtons()
        
        //캐러셀 컨테이너 관련
        addContainerViews(firstView, secondView, thirdView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
        let layout = CarouselLayout()
        
        // TODO: 컬렉션뷰 자체의 비율을 고정하는 작업 하기
        // 현재 페이지의 크기 비율을 지정, 피그마 참고했습니다.
        let centerItemWidthScale: CGFloat = 327/375
        let centerItemHeightScale: CGFloat = 1
        
        layout.itemSize = CGSize(width: carouselCV.frame.size.width*centerItemWidthScale, height: carouselCV.frame.size.height*centerItemHeightScale)

        layout.sideItemScale = 464/520
        layout.spacing = 12
        layout.sideItemAlpha = 0.4
        layout.animationStatus = status
        carouselCV.collectionViewLayout = layout
            
        self.carouselCV?.register(carouselCVC.self, forCellWithReuseIdentifier: "carouselCVC")
        
        self.carouselCV?.reloadData()
    func setButtons() {
        firstViewButton.statusCV = 0
        firstViewButton.backgroundColor = .clear
        firstViewButton.setTitle("캐러셀 1", for: .normal)
        firstViewButton.setTitleColor(.black, for: .normal)
        firstViewButton.setTitleColor(.gray, for: .highlighted)
        secondViewButton.statusCV = 1
        secondViewButton.backgroundColor = .clear
        secondViewButton.setTitle("캐러셀 2", for: .normal)
        secondViewButton.setTitleColor(.black, for: .normal)
        secondViewButton.setTitleColor(.gray, for: .highlighted)
        thirdViewButton.statusCV = 2
        thirdViewButton.backgroundColor = .clear
        thirdViewButton.setTitle("캐러셀 3", for: .normal)
        thirdViewButton.setTitleColor(.black, for: .normal)
        thirdViewButton.setTitleColor(.gray, for: .highlighted)
        
        secondViewButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(150)
            make.centerX.equalToSuperview()
        }
        
        firstViewButton.snp.makeConstraints { make in
            make.centerY.equalTo(secondViewButton.snp.centerY)
            make.trailing.equalTo(secondViewButton.snp.leading).offset(-40)
        }
        
        thirdViewButton.snp.makeConstraints { make in
            make.centerY.equalTo(secondViewButton.snp.centerY)
            make.leading.equalTo(secondViewButton.snp.trailing).offset(40)
        }
    }
    
    func addContainerViews(_ views: UIView...) {
        for view in views {
            self.view.addSubview(view)
            view.snp.makeConstraints { make in
                make.leading.trailing.equalToSuperview()
                make.top.equalToSuperview().offset(300)
                make.bottom.equalToSuperview().offset(-95)
            }
        }
    }
    
    func setContainerViews() {
        secondView.backgroundColor = .blue
        thirdView.backgroundColor = .purple
    }
    
    func addSubviewss(_ views: UIView...) {
        for view in views {
            self.view.addSubview(view)
        }
    }
    
    func addTargets(_ buttons: MyButton...) {
        for button in buttons {
            button.addTarget(self, action: #selector(changeCollectionView), for: .touchUpInside)
        }
    }
    }
    
    // 버튼을 터치함에 따라서 animationStatus을 변경해준다.
    @IBAction func touchChangeAnimation(_ sender: Any) {
        if !isClicked {
            isClicked = true
            addCollectionView(isClicked)
        } else {
            isClicked = false
            addCollectionView(isClicked)
        }
    }
    
}

extension CarouselVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 20
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "carouselCVC", for: indexPath) as! carouselCVC

        cell.customView.image = UIImage(named: imageNames[indexPath.row])
        return cell
    }
}

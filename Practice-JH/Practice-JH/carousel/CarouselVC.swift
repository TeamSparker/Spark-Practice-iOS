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
    
//    @IBOutlet weak var carouselCV: UICollectionView!
    private var isClicked: Bool = false
    private let cellCaseList: [carouselCase] = [.firstView, .secondView, .thirdView]
    
    let firstViewButton = MyButton()
    let secondViewButton = MyButton()
    let thirdViewButton = MyButton()
    var selectedItem = 3

    let imageNames: [String] = ["cell_one","cell_two","cell_three"
                                ,"cell_four","cell_one","cell_two",
                                "cell_three","cell_four","cell_one",
                                "cell_two","cell_three","cell_four",
                                "cell_one","cell_two","cell_three",
                                "cell_four","cell_one","cell_two",
                                "cell_three","cell_four"]
    
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
        addTargets(firstViewButton, secondViewButton, thirdViewButton)
        
        //캐러셀 컨테이너 관련
        addContainerViews(firstView, secondView, thirdView)
        print("안녕하세ㅛㅇ")
        print(self.firstView.collectionView.frame.width)
        setContainerViews()
        setCarousels()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    func setCarousels() {
        let layout = CarouselLayout()
        
        let centerItemWidthScale: CGFloat = 327/375
        let centerItemHeightScale: CGFloat = 1
        
        layout.itemSize = CGSize(width: 500*centerItemWidthScale, height: 300*centerItemHeightScale)


        layout.sideItemScale = 464/520
        layout.spacing = 12
        layout.sideItemAlpha = 0.4
        
        
        let layout1 = CarouselLayout()
        
        layout1.itemSize = CGSize(width: 500*centerItemWidthScale, height: 300*centerItemHeightScale)

        layout1.sideItemScale = 464/520
        layout1.spacing = 12
        layout1.sideItemAlpha = 0.4
        
        let layout2 = CarouselLayout()
        
        layout2.itemSize = CGSize(width: 500*centerItemWidthScale, height: 300*centerItemHeightScale)

        layout2.sideItemScale = 464/520
        layout2.spacing = 12
        layout2.sideItemAlpha = 0.4
            
        firstView.collectionView.collectionViewLayout = layout
        firstView.collectionView.register(thirdCVC.self, forCellWithReuseIdentifier: "thirdCVC")
        
        secondView.collectionView.collectionViewLayout = layout1

        secondView.collectionView.register(thirdCVC.self, forCellWithReuseIdentifier: "thirdCVC")
//
        thirdView.collectionView.collectionViewLayout = layout2

        thirdView.collectionView.register(thirdCVC.self, forCellWithReuseIdentifier: "thirdCVC")

        firstView.collectionView.reloadData()
        secondView.collectionView.reloadData()
        thirdView.collectionView.reloadData()
    }
    
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
    
    func setDelegate() {
        self.firstView.collectionView.delegate = self
        self.firstView.collectionView.dataSource = self
        self.secondView.collectionView.delegate = self
        self.secondView.collectionView.dataSource = self
        self.thirdView.collectionView.delegate = self
        self.thirdView.collectionView.dataSource = self
    }
    
//    func addCollectionView(_ status: Bool){
//
//        let layout = CarouselLayout()
//
//        // TODO: 컬렉션뷰 자체의 비율을 고정하는 작업 하기
//        // 현재 페이지의 크기 비율을 지정, 피그마 참고했습니다.
//        let centerItemWidthScale: CGFloat = 327/375
//        let centerItemHeightScale: CGFloat = 1
//
//        layout.itemSize = CGSize(width: carouselCV.frame.size.width*centerItemWidthScale, height: carouselCV.frame.size.height*centerItemHeightScale)
//
//        layout.sideItemScale = 464/520
//        layout.spacing = 12
//        layout.sideItemAlpha = 0.4
//        layout.animationStatus = status
//        carouselCV.collectionViewLayout = layout
//
//        self.carouselCV?.register(carouselCVC.self, forCellWithReuseIdentifier: "carouselCVC")
//
//        self.carouselCV?.reloadData()
//    }
    
    // 버튼을 터치함에 따라서 animationStatus을 변경해준다.
    @IBAction func touchChangeAnimation(_ sender: Any) {
        if !isClicked {
            isClicked = true
//            addCollectionView(isClicked)
        } else {
            isClicked = false
//            addCollectionView(isClicked)
        }
    }
    
    @objc func changeCollectionView(sender: MyButton) {
        let status: Int = (sender.statusCV)!
        switch status {
        case 0:
            firstView.isHidden = false
            print(self.firstView.frame.width)
            secondView.isHidden = true
            thirdView.isHidden = true
            selectedItem = 1
            print(firstView.layer.name)
//            firstView.position.z
        case 1:
            firstView.isHidden = true
            secondView.isHidden = false
            thirdView.isHidden = true
            selectedItem = 2
            secondView.collectionView.reloadData()
            firstView.collectionView.reloadData()
            thirdView.collectionView.reloadData()
//            secondVIew.position.z
        default:
            firstView.isHidden = true
            secondView.isHidden = true
            thirdView.isHidden = false
            selectedItem = 3
//            thirdView.position.z
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
//
//        let selected = collectionView.superview?.layer.name
////        let superView = collectionView.superview.layer.name
//
//        if selected == "firstView" {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "thirdCVC", for: indexPath) as! thirdCVC
            
            cell.customView.image = UIImage(named: imageNames[indexPath.row])
            return cell
//        }
//        if selected == "firstView" {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "firstCVC", for: indexPath) as! firstCVC
//
//            cell.customView.image = UIImage(named: imageNames[indexPath.row])
//            return cell
//        } else
//        {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "firstCVC", for: indexPath) as! firstCVC
//
//            cell.customView.image = UIImage(named: imageNames[indexPath.row])
//            return cell
//        }

//            print("2왔당")
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "secondCVC", for: indexPath) as! secondCVC
//
//            cell.customView.image = UIImage(named: imageNames[indexPath.row])
//            return cell\
//            print("3왔당")
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "thirdCVC", for: indexPath) as! thirdCVC
//
//            cell.customView.image = UIImage(named: imageNames[indexPath.row])
//            return cell
        
        
        //        switch superView {
//        case .firstView:
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "firstCVC", for: indexPath) as! firstCVC
//
//            cell.customView.image = UIImage(named: imageNames[indexPath.row])
//            return cell
//        case .secondView:
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "secondCVC", for: indexPath) as! secondCVC
//
//            cell.customView.image = UIImage(named: imageNames[indexPath.row])
//            return cell
//        case .thirdView:
        //            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "thirdCVC", for: indexPath) as! secondCVC
        //
        //            cell.customView.image = UIImage(named: imageNames[indexPath.row])
        //            return cell
        //        default:
        //            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "thirdCVC", for: indexPath) as! secondCVC
        //
        //            cell.customView.image = UIImage(named: imageNames[indexPath.row])
        //            return cell
        //        }
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "firstCVC", for: indexPath) as! firstCVC
//
//        cell.customView.image = UIImage(named: imageNames[indexPath.row])
//        return cell

        
        
//        let cellcase = cellCaseList[indexPath.row]
//
//        switch(cellcase){
//        case .first:
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "carouselCVC", for: indexPath) as! carouselCVC
//
//            cell.customView.image = UIImage(named: imageNames[indexPath.row])
//            return cell
//        case .second:
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "secondCVC", for: indexPath) as! secondCVC
//
//            cell.customView.image = UIImage(named: imageNames[indexPath.row])
//            return cell
//        default:
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "secondCVC", for: indexPath) as! secondCVC
//
//            cell.customView.image = UIImage(named: imageNames[indexPath.row])
//            return cell
//        }

    }
}
//
//extension CarouselVC: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let centerItemWidthScale: CGFloat = 327/375
//        let centerItemHeightScale: CGFloat = 1
//
//        let itemSize = CGSize(width: firstView.frame.width*centerItemWidthScale, height: firstView.frame.height*centerItemHeightScale)
//
//      return itemSize
//    }
//}

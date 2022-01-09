//
//  CarouselVC.swift
//  Practice-JH
//
//  Created by Junho Lee on 2022/01/07.
//

import UIKit

class CarouselVC: UIViewController {
    
    @IBOutlet weak var carouselCV: UICollectionView!
    var isClicked: Bool = false

    
    let imageNames: [String] = ["cell_one","cell_two","cell_three","cell_four","cell_one","cell_two","cell_three","cell_four","cell_one","cell_two","cell_three","cell_four","cell_one","cell_two","cell_three","cell_four","cell_one","cell_two","cell_three","cell_four"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addCollectionView(isClicked)
        setDelegate()
        carouselCV.backgroundColor = .clear
        self.view.backgroundColor = .white
    }
    
    func setDelegate() {
        self.carouselCV?.delegate = self
        self.carouselCV?.dataSource = self
    }
    
    func addCollectionView(_ status: Bool){

        let layout = CarouselLayout()
        
        // 현재 페이지의 크기 비율을 지정, 피그마 참고했습니다.
        let centerItemWidthScale: CGFloat = 327/375
        let centerItemHeightScale: CGFloat = 1
        
        layout.itemSize = CGSize(width: carouselCV.frame.size.width*centerItemWidthScale, height: carouselCV.frame.size.height*centerItemHeightScale)

        layout.sideItemScale = 464/520
        layout.spacing = 12
        layout.sideItemAlpha = 0.4
        layout.animationStatus = status
        print(layout.animationStatus)
        carouselCV.collectionViewLayout = layout
            
        self.carouselCV?.register(carouselCVC.self, forCellWithReuseIdentifier: "carouselCVC")
        
        self.carouselCV?.reloadData()
    }
    
    @IBAction func touchChangeAnimation(_ sender: Any) {
        if !isClicked {
            isClicked = true
            setAnimationStyle(isClicked)
        } else {
            isClicked = false
            setAnimationStyle(isClicked)
        }
    }
    
    func setAnimationStyle(_ type: Bool) {
        addCollectionView(type)
    }
}

extension CarouselVC: UICollectionViewDelegate, UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//       return UIEdgeInsets(top: 100, left: 30, bottom: 100, right: 30)
//    }
    
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

//
//  ViewController.swift
//  StickyHeader
//
//  Created by 양수빈 on 2022/01/10.
//

import UIKit

import SnapKit

class ViewController: UIViewController {
    
    let collectionViewFlowlayout = UICollectionViewFlowLayout()
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowlayout)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setLayout()
        setCollcetionView()
        
        /// statusBar 높이 확인용
        print(UIApplication.shared.statusBarFrame.height)
        print(view.window?.windowScene?.statusBarManager?.statusBarFrame.size.height ?? 9)
    }

    func setUI() {
    }
    
    func setLayout() {
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(UIApplication.shared.statusBarFrame.height)
            make.leading.bottom.trailing.equalToSuperview()
        }
    }
    
    func setCollcetionView() {
        collectionView.backgroundColor = .lightGray
        collectionViewFlowlayout.scrollDirection = .vertical
        collectionView.showsVerticalScrollIndicator = false
        
        /// cell register
        collectionView.register(CustomCVC.self, forCellWithReuseIdentifier: CustomCVC.identifier)
        collectionView.register(CustomHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CustomHeaderView.identifier)
        
        /// collectionView를 상단바 부분부터 시작하도록 하는 코드
//        collectionView.contentInset.top = -UIApplication.shared.statusBarFrame.height
//        collectionView.contentInsetAdjustmentBehavior = .never
        
        /// delegate, datasource
        collectionView.delegate = self
        collectionView.dataSource = self
        
        /// sticky header을 가능하도록 하는 코드
        collectionViewFlowlayout.sectionHeadersPinToVisibleBounds = true
    }
}

extension ViewController: UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 6
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 2
        case 2:
            return 3
        case 3:
            return 4
        case 4:
            return 4
        case 5:
            return 8
        default:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCVC.identifier, for: indexPath) as? CustomCVC else { return UICollectionViewCell() }
        
        cell.textLabel.text = "안녕하신가"
        cell.backgroundColor = .orange
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let cell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CustomHeaderView", for: indexPath) as? CustomHeaderView else { return UICollectionReusableView() }
        
        cell.textLabel.text = "Header \(indexPath.section)"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = UIScreen.main.bounds.width
        
        return CGSize(width: width, height: 80)
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = UIScreen.main.bounds.width
        
        return CGSize(width: width, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {

        return 20
    }
}

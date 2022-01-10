//
//  ViewController.swift
//  StickyHeader
//
//  Created by 양수빈 on 2022/01/10.
//

import UIKit

import SnapKit

class ViewController: UIViewController {
    
    // MARK: - Dummy Data
    var dummyDataList: Array = [ ["date": "2022-11-11", "userName": "양수빈", "sparkTitle": "간식먹기", "sparkCount": "22"],
                            ["date": "2022-11-11", "userName": "감자", "sparkTitle": "간식먹기222", "sparkCount": "1"],
                            ["date": "2022-11-11", "userName": "김", "sparkTitle": "아아아간식먹기", "sparkCount": "6"],
                            ["date": "2022-11-10", "userName": "옹", "sparkTitle": "아아 마셔", "sparkCount": "88"],
                            ["date": "2022-11-10", "userName": "우와", "sparkTitle": "커피 홀짝", "sparkCount": "3"],
                            ["date": "2022-11-9", "userName": "우와", "sparkTitle": "홀짝 커피", "sparkCount": "44"],
                            ["date": "2022-11-9", "userName": "뭐지", "sparkTitle": "하하하하", "sparkCount": "2"],
                            ["date": "2022-11-9", "userName": "하하", "sparkTitle": "쉽지않네", "sparkCount": "98"],
                            ["date": "2022-11-9", "userName": "호호", "sparkTitle": "덤이데잍어", "sparkCount": "75"] ]
    var dateList: [String] = []
    
    // MARK: - Properties
    let collectionViewFlowlayout = UICollectionViewFlowLayout()
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowlayout)
    
    // MARK: - View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLayout()
        setCollcetionView()
        setData()
    }
    
    // MARK: - Methods
    func setLayout() {
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func setData() {
        var indexPath = 0
        
        print(dummyDataList[indexPath]["date"])
        print(type(of: dummyDataList[indexPath]["date"]))
        print(dummyDataList[indexPath])
        
        while indexPath < dummyDataList.count {
            if dateList.isEmpty {
                dateList.append(dummyDataList[indexPath]["date"] as! String)
                indexPath += 1
            } else {
                let day: String = dummyDataList[indexPath]["date"] ?? ""
                if !(dateList.contains(day)) {
                    dateList.append(day)
                }
                indexPath += 1
            }
        }
        print("total dateList: ", dateList)
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

// MARK: - extension
extension ViewController: UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dateList.count
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var itemCount = 0
        var indexPath = 0
        
        while indexPath < dummyDataList.count {
            if dateList[section] == dummyDataList[indexPath]["date"] {
                itemCount += 1
                indexPath += 1
            } else {
                indexPath += 1
            }
        }
        
        return itemCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCVC.identifier, for: indexPath) as? CustomCVC else { return UICollectionViewCell() }
        
        cell.textLabel.text = "안녕하신가 \(indexPath.row)"
        cell.backgroundColor = .white
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let cell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CustomHeaderView", for: indexPath) as? CustomHeaderView else { return UICollectionReusableView() }
        
        cell.textLabel.text = "Header \(indexPath.section)"
        cell.backgroundColor = .darkGray
        
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

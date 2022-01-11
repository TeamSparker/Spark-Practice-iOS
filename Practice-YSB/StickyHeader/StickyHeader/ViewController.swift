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
    var dummyDataList: Array = [ ["date": "2022-11-11", "userName": "양수빈", "sparkTitle": "간식먹기", "sparkCount": "1"],
                            ["date": "2022-11-11", "userName": "감자", "sparkTitle": "간식먹기222", "sparkCount": "2"],
                            ["date": "2022-11-11", "userName": "김", "sparkTitle": "아아아간식먹기", "sparkCount": "3"],
                            ["date": "2022-11-10", "userName": "옹", "sparkTitle": "아아 마셔", "sparkCount": "4"],
                            ["date": "2022-11-10", "userName": "우와", "sparkTitle": "커피 홀짝", "sparkCount": "5"],
                            ["date": "2022-11-9", "userName": "우와", "sparkTitle": "홀짝 커피", "sparkCount": "6"],
                            ["date": "2022-11-9", "userName": "뭐지", "sparkTitle": "하하하하", "sparkCount": "7"],
                            ["date": "2022-11-9", "userName": "하하", "sparkTitle": "쉽지않네", "sparkCount": "8"],
                            ["date": "2022-11-9", "userName": "호호", "sparkTitle": "덤이데잍어", "sparkCount": "9"],
                            ["date": "2022-11-7", "userName": "s", "sparkTitle": "덤이데sdfdfdfdf잍어", "sparkCount": "10"],
                            ["date": "2022-11-7", "userName": "호sgggg호", "sparkTitle": "덤이sddd데잍어", "sparkCount": "11"] ]
    
    var newDummyDataList: Array = [ ["date": "2022-11-7", "userName": "양수빈", "sparkTitle": "간식먹기", "sparkCount": "12"],
                            ["date": "2022-11-7", "userName": "감자", "sparkTitle": "간식먹기222", "sparkCount": "13"],
                            ["date": "2022-11-4", "userName": "김", "sparkTitle": "아아아간식먹기", "sparkCount": "14"],
                            ["date": "2022-11-4", "userName": "옹", "sparkTitle": "아아 마셔", "sparkCount": "15"],
                            ["date": "2022-11-3", "userName": "우와", "sparkTitle": "커피 홀짝", "sparkCount": "16"],
                            ["date": "2022-11-3", "userName": "우와", "sparkTitle": "홀짝 커피", "sparkCount": "17"],
                            ["date": "2022-11-3", "userName": "뭐지", "sparkTitle": "하하하하", "sparkCount": "18"],
                            ["date": "2022-11-3", "userName": "하하", "sparkTitle": "쉽지않네", "sparkCount": "19"],
                            ["date": "2022-11-3", "userName": "호호", "sparkTitle": "덤이데잍어", "sparkCount": "20"],
                            ["date": "2022-11-2", "userName": "s", "sparkTitle": "덤이데sdfdfdfdf잍어", "sparkCount": "21"],
                            ["date": "2022-11-2", "userName": "호sgggg호", "sparkTitle": "덤이sddd데잍어", "sparkCount": "22"] ]
    
    // MARK: - Properties
    let collectionViewFlowlayout = UICollectionViewFlowLayout()
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowlayout)
    var index = 0
    var dateList: [String] = []
    var firstList: [Any] = []
    var secondList: [Any] = []
    var thirdList: [Any] = []
    var fourthList: [Any] = []
    var fifthList: [Any] = []
    var sixthList: [Any] = []
    var seventhList: [Any] = []
    
    // MARK: - View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLayout()
        setCollcetionView()
        setData(datalist: dummyDataList)
    }
    
    // MARK: - Methods
    func setLayout() {
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func setData(datalist: Array<Dictionary<String, String>>) {
        var indexPath = 0
        var sectionCount = 0 /// section을 돌기 위한 변수
        
//        print(dummyDataList[indexPath]["date"])
//        print(type(of: dummyDataList[indexPath]["date"]))
//        print(dummyDataList[indexPath])
        
//        print(datalist)
//        print(type(of: datalist))
//        print(dummyDataList)
//        print(type(of: dummyDataList))
        while indexPath < datalist.count {
            if dateList.isEmpty {
                dateList.append(datalist[indexPath]["date"] as! String)
                indexPath += 1
            } else {
                let day: String = datalist[indexPath]["date"] ?? ""

                if !(dateList.contains(day)) {
                    dateList.append(day)
                }

                indexPath += 1
            }
        }

        // TODO: - section별 리스트 생성
        while sectionCount < dateList.count {
            var index = 0
            while index < datalist.count && !datalist.isEmpty && sectionCount != dateList.count {

                if dateList[sectionCount] == datalist[index]["date"] {
                    switch sectionCount {
                    case 0:
                        firstList.append(datalist[index])
                    case 1:
                        secondList.append(datalist[index])
                    case 2:
                        thirdList.append(datalist[index])
                    case 3:
                        fourthList.append(datalist[index])
                    case 4:
                        fifthList.append(datalist[index])
                    case 5:
                        sixthList.append(datalist[index])
                    case 6:
                        seventhList.append(datalist[index])
                    default:
                        seventhList.append(datalist[index])
                    }

                }
                index += 1
            }
            sectionCount += 1
        }
        
//        print("1: ", firstList)
//        print("2: ", secondList)
//        print("2: ", thirdList)
//        print("4: ", fourthList)
//        print("5: ", fifthList)
//        print("6: ", sixthList)
//        print("7: ", seventhList)
//        print("-------------------------------------------------------")
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
        
        var alist: [String:String] = [:]
        
        // TODO: - section별 데이터 넣기
        switch indexPath.section {
        case 0:
            alist = firstList[indexPath.item] as! [String : String]
        case 1:
            alist = secondList[indexPath.item] as! [String : String]
        case 2:
            alist = thirdList[indexPath.item] as! [String : String]
        case 3:
            alist = fourthList[indexPath.item] as! [String : String]
        case 4:
            alist = fifthList[indexPath.item] as! [String : String]
        case 5:
            alist = sixthList[indexPath.item] as! [String : String]
        case 6:
            alist = seventhList[indexPath.item] as! [String : String]
        default:
            alist = firstList[indexPath.item] as! [String : String]
        }
        
        cell.titleLabel.text = "\(String(describing: alist["sparkCount"]!))"
        cell.userNameLabel.text = "\(String(describing: alist["userName"]!))"
        cell.backgroundColor = .white
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let cell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CustomHeaderView", for: indexPath) as? CustomHeaderView else { return UICollectionReusableView() }
        cell.dateLabel.text = "\(dateList[indexPath.section])"
        cell.backgroundColor = .systemIndigo
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = UIScreen.main.bounds.width
        
        return CGSize(width: width, height: 60)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y + 1) >= (scrollView.contentSize.height - scrollView.frame.size.height) {
            if index < 1 {
                dummyDataList.append(contentsOf: newDummyDataList)
                setData(datalist: newDummyDataList)
                collectionView.reloadData()
                index += 1
            } else {
                print("끝입니다")
            }
        }
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

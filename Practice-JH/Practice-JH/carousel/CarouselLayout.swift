//
//  CarouselLayout.swift
//  Practice-JH
//
//  Created by Junho Lee on 2022/01/07.
//

import UIKit

class CarouselLayout: UICollectionViewFlowLayout {
    
    public var sideItemScale: CGFloat = 0.5
    public var sideItemAlpha: CGFloat = 0.5
    public var spacing: CGFloat = 10

    public var isPagingEnabled: Bool = false
    
    private var isSetup: Bool = false
    
    // MARK: prepare는 사용자가 스크롤 시 매번 호출된다고 한다. setupLayout()은 초기에 한 번만 호출되도록 한 것이다.
    override public func prepare() {
        super.prepare()
        if isSetup == false {
            setupLayout()
            isSetup = true
        }
    }
    
    private func setupLayout() {
        guard let collectionView = self.collectionView else {return}

        let collectionViewSize = collectionView.bounds.size
        
        let xInset = (collectionViewSize.width - self.itemSize.width) / 2
        let yInset = (collectionViewSize.height - self.itemSize.height) / 2
        
        self.sectionInset = UIEdgeInsets(top: yInset, left: xInset, bottom: yInset, right: xInset)
        
        let itemWidth = self.itemSize.width
        
        let scaledItemOffset =  (itemWidth - itemWidth*self.sideItemScale) / 2
        self.minimumLineSpacing = spacing - scaledItemOffset

        self.scrollDirection = .horizontal
    }
    
    public override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    /// 모든 셀과 뷰에 대한 속성을 UICollectionViewLayoutAttributes의 배열로 반환해준다고 한다.
    /// 이 속성들을 사용하기 위해 map 함수를 통해 리턴해주었다.
    public override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let superAttributes = super.layoutAttributesForElements(in: rect),
            let attributes = NSArray(array: superAttributes, copyItems: true) as? [UICollectionViewLayoutAttributes]
            else { return nil }
        
        /// transformLayoutAttributes() 함수를 이용해 기존 attributes 속성들을 원하는 대로 변환하고
        /// 이를 attributes에 다시 매핑하여 UICollectionViewLayoutAttributes로 반환한다
        return attributes.map({ self.transformLayoutAttributes(attributes: $0) })
    }
    
    private func transformLayoutAttributes(attributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        
        guard let collectionView = self.collectionView else {return attributes}
        
        // 순서대로 컬렉션뷰 크기의 절반, 컬렉션뷰의 컨텐트의 x좌표:예를 들어 한 셀이 지나면 셀의 크기만큼 더해진다, 현재 컨텐트의 오프셋과 각 셀의 중심 좌표의 차이다 : 이는 컬렉션뷰의 오리진 x좌표와 셀의 중심 사이의 거리라고 볼 수 있다.
        // 즉, center는 컬렉션뷰 좌표계를 기준으로 각 셀의 중심의 x표이다.
        let collectionCenter = collectionView.frame.size.width / 2
        let contentOffset = collectionView.contentOffset.x
        let center = attributes.center.x - contentOffset        
        
        // 멀리 있는 경우, ratio가 0이 되며 sideItem으로 판별하여 alpha와 scale이 된다.
        // maxDistance보다 가까운 경우, ratio가 1에 가까워지면서 alpha와 scale 값이 1로 온전해진다.
        // distance의 경우, 컬렉션뷰 중심과 각 셀의 중심 사이의 거리이다. 컬렉션뷰 중심으로 셀이 가까이 올수록 거리가 줄어든다. maxdistance를 넣은 이유는 ratio가 음수가 되는 것을 방지하기 위해서이다.
        let maxDistance = self.itemSize.width + self.minimumLineSpacing
        let distance = min(abs(collectionCenter - center), maxDistance)
        
        let ratio = (maxDistance - distance)/maxDistance

        // 아래에 있는 1을 바꿔서 중심으로 올수록 흐려지거나, 작게 만들 수 있다.
        let alpha = ratio * (1 - self.sideItemAlpha) + self.sideItemAlpha
        let scale = ratio * (1 - self.sideItemScale) + self.sideItemScale
        
        attributes.alpha = alpha
        
        // fakescale은 중심에서 -1, 멀어졌을 때 1
        var fakescale = (492/520-scale)*(520/28)
        // realscale은 중심에서 0, 멀어졌을 때 -1
        var realscale = (-1-fakescale)*0.5
        print(realscale)
        
        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
        let dist = attributes.frame.midX - visibleRect.midX
        var transform = CATransform3DScale(CATransform3DIdentity, scale, scale, 1)
        
        // 1이 한 바퀴 회전이다. 360도임
        // CATransform은 한 번에 하나씩만 사용 가능하다.
        transform = CATransform3DMakeRotation(realscale*8, 0, 1, 0)
        
        // 마지막 인자는 z좌표이고, 각 셀이 어떤 셀의 위에 있을지 아닐지를 결정한다. 아래 코드는 거리가 멀수록 화면에서 뒤로 가게끔 만든다(우리가 화면을 바라본다고 가정할 때). +값이라면 우리 눈 앞으로 다가오는 것이다.
        transform = CATransform3DTranslate(transform, 0, 0, -abs(dist/1000))
        attributes.transform3D = transform
        
        return attributes
    }
    
    // MARK: 페이징 가능하게 해주는 코드
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {

            guard let collectionView = self.collectionView else {
                let latestOffset = super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
                return latestOffset
            }

            let targetRect = CGRect(x: proposedContentOffset.x, y: 0, width: collectionView.frame.width, height: collectionView.frame.height)
            guard let rectAttributes = super.layoutAttributesForElements(in: targetRect) else { return .zero }

            var offsetAdjustment = CGFloat.greatestFiniteMagnitude
            let horizontalCenter = proposedContentOffset.x + collectionView.frame.width / 2

            for layoutAttributes in rectAttributes {
                let itemHorizontalCenter = layoutAttributes.center.x
                if (itemHorizontalCenter - horizontalCenter).magnitude < offsetAdjustment.magnitude {
                    offsetAdjustment = itemHorizontalCenter - horizontalCenter
                }
            }
        
            //proposedContentOffset을 조절하여 멈추기 원하는 점을 조절가능하다.
            return CGPoint(x: proposedContentOffset.x + offsetAdjustment, y: proposedContentOffset.y)
        }
}

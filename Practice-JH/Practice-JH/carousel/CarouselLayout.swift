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
    public var animationStatus: Bool = true

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
        
        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
        let dist = attributes.frame.midX - visibleRect.midX
        var transform = CATransform3DScale(CATransform3DIdentity, scale, scale, 1)
        
        switch animationStatus{
        case true:
            // fakescale은 중심에서 -1, 멀어졌을 때 1
            let fakescale = (492/520-scale)*(520/28)
            // realscale은 중심에서 0, 멀어졌을 때 -1
            let realscale = (-1-fakescale)*0.5
            // 1이 한 바퀴 회전이다. 360도임
            // CATransform은 한 번에 하나씩만 사용 가능하다.
            transform = CATransform3DMakeRotation(realscale*8, 0, 1, 0)
        default:
            // 마지막 인자는 z좌표이고, 각 셀이 어떤 셀의 위에 있을지 아닐지를 결정한다. 아래 코드는 거리가 멀수록 화면에서 뒤로 가게끔 만든다(우리가 화면을 바라본다고 가정할 때). +값이라면 우리 눈 앞으로 다가오는 것이다.
            transform = CATransform3DTranslate(transform, 0, 0, -abs(dist/1000))
        }
        attributes.transform3D = transform
        
        return attributes
    }
    
    // MARK: 페이징 가능하게 해주는 코드
    // 이 함수는 현재 스크롤의 방향과 속력을 고려하여 스크롤을 멈출 ContentOffset을 지정해준다. 따라서, 멈추길 원하는 목적하는 CGPoint를 함수 내에서 반환해주면 된다.
    // 우리는 각 셀의 center와, 컬렉션뷰의 center를 일치시키고자 한다.
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {

            // 여기서 collectionView = self.collectionVIew의 의미를 모르겠어요. 컬렉션뷰는 항상 있는건데 왜 else로 빠지는걸까요?
            guard let collectionView = self.collectionView else {
                let latestOffset = super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
                print(latestOffset)
                return latestOffset
            }
        
            // print(targetRect)를 통해 targertRect가 하나만 생성된다는 것을 확인했다. 컨텐츠가 멈추기 원하는 목표지점에 rect를 생성해주는 코드이다. 우리는, 이 rect에 포함되는 셀들 중에 컬렉션뷰의 중심에 가장 가까이 있는 셀의 중심에 멈춰야 한다.
            let targetRect = CGRect(x: proposedContentOffset.x, y: 0, width: collectionView.frame.width, height: collectionView.frame.height)
        
            // layoutAttrbutesForeElemets는 parameter로 취하는 targetRect의 범위 안에 있는 셀들의 UICollectionViewLayoutAttributes를 반환해준다. 따라서, Rect의 위치에 따라 2개 셀의 레이아웃 애트리뷰트들이 반환되거나, 3개 셀의 레이아웃 애트리뷰트들이 반환된다.
            // targetRect의 width를 2000으로 늘린다면? -> 2000의 범위 안에 있는 셀들의 속성이 반환된다.
            guard let rectAttributes = super.layoutAttributesForElements(in: targetRect) else { return .zero }
        
            // finite number란, 무한보다 작은 셀 수 있는 숫자이다. 여기에 greatest가 붙어서, 가장 큰 양의 숫자를 반환한다. 시스템 상에서 가장 큰 소수의 값이다. _MAX를 생각하면 된다.
            var offsetAdjustment = CGFloat.greatestFiniteMagnitude
        
            // horizontalCenter는 컨텐츠오프셋의 x좌표에 컬렉션뷰의 절반을 더해서 새로운 목표지점이 될 x좌표를 만들어준다.
            let horizontalCenter = proposedContentOffset.x + collectionView.frame.width / 2

            // 여러 개 셀의 레이아웃 속성들을 비교하여,
            // magnitude는 소수의 절대값을 말한다. 즉, (itemHorizontalCenter - horizontalCenter).magnitude는 변위를 거리로 바꿔준다.
            // if 문의 역할은, 두 개의 셀 중에서 컬렉션뷰 중심까지의 거리가 더 가까운 셀의 거리를 offsetAdjustment에 저장해주는 것이다. if문 안의 대입값에는 magnitude가 없는데, 이는 -값과 +값(변위)을 모두 사용해야 하기 때문이다.
            for layoutAttributes in rectAttributes {
                let itemHorizontalCenter = layoutAttributes.center.x
                if (itemHorizontalCenter - horizontalCenter).magnitude < offsetAdjustment.magnitude {
                    offsetAdjustment = itemHorizontalCenter - horizontalCenter
                }
            }
        
            // 이렇게 원래 스크롤 시 멈추려던 좌표에서, 조정될 변위를 더해줘서 셀의 중심과 컬렉션뷰의 중심을 일치시켜주면 페이징과 같이 기능하게 된다.
            return CGPoint(x: proposedContentOffset.x + offsetAdjustment, y: proposedContentOffset.y)
        }
}

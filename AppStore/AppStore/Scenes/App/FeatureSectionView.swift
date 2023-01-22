//
//  FeatureSectionView.swift
//  AppStore
//
//  Created by 이민아 on 2023/01/20.
//

import SnapKit
import UIKit

final class FeatureSectionView: UIView {
    //1. feature 데이터 받을 배열 정의
    private var featureList: [Feature] = []
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal //가로 스크롤
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true //가로로 스크롤을 했을 때 페이지 레이아웃 딱 맞게 됨
        collectionView.backgroundColor = .systemBackground
        collectionView.showsHorizontalScrollIndicator = false //스크롤바 감춤
        
        collectionView.register(FeatureSectionCollectionViewCell.self, forCellWithReuseIdentifier: "FeatureSectionCollectionViewCell")
        
        return collectionView
    }()
    
    private let separatorView = SeparatorView(frame: .zero)
    
    //viewController가 아닌 UIView이기 때문에, viewDidLoad() 사용불가 -> init으로 초기화
    override init(frame:CGRect) {
        super.init(frame: frame)
        
        setupViews()
        
        fetchData()
        collectionView.reloadData() //3. 데이터를 가져온 후 컬렉션뷰에 데이터를 꼭 reload 해야함!
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FeatureSectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //10
        //6. 가져온 데이터 개수 만큼
        featureList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeatureSectionCollectionViewCell", for: indexPath) as? FeatureSectionCollectionViewCell
        //cell?.setup()
        //5.dataSource 수정 : 위치에 맞는 아이템 주입
        let feature = featureList[indexPath.item]
        cell?.setup(feature: feature)
        return cell ?? UICollectionViewCell()
    }
}

extension FeatureSectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width-32.0, height: frame.width) //32.0 뺀 이유: 양쪽에 margin 16씩 있기 때문. height은 width와 동일하게(정사각형)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets { //inset. page넘겼을 때도 inset 유지
        UIEdgeInsets(top: 0.0, left: 16.0, bottom: 0.0, right: 16.0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        32.0
    }
}

private extension FeatureSectionView {
    func setupViews() {
        [collectionView,separatorView].forEach{addSubview($0)}
        
        collectionView.snp.makeConstraints{
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.top.equalToSuperview().inset(16.0)
            $0.height.equalTo(snp.width)
            $0.bottom.equalToSuperview()
        }
        separatorView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.top.equalTo(collectionView.snp.bottom).offset(16.0)
            $0.bottom.equalToSuperview()
        }
    }
    
    //2. data 가져오기
    func fetchData() {
        guard let url = Bundle.main.url(forResource: "Feature", withExtension: "plist") else {return}
        do{
            let data = try Data(contentsOf: url)
            let result = try PropertyListDecoder().decode([Feature].self, from: data)
            featureList = result
        } catch {}
    }
}

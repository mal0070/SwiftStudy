//
//  RankingFeatureSectionView.swift
//  AppStore
//
//  Created by 이민아 on 2023/01/20.
//

import SnapKit
import UIKit

final class RankingFeatureSectionView: UIView {
    //private let cellHeight: CGFloat = 30.0 //한 섹션에 3개가 똑같이 고정되어서 나오므로, 높이 고정시킴
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "iPhone이 처음이라면"
        label.font = .systemFont(ofSize: 18.0, weight: .black)
    
        return label
    }()
    
    private lazy var showAllAppsButton: UIButton = {
        let button = UIButton()
        button.setTitle("모두 보기", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14.0, weight: .semibold)
        //button.backgroundColor = .lightGray
        return button
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 32.0
        layout.minimumInteritemSpacing = 0.0
        layout.sectionInset = UIEdgeInsets(top: 0.0, left: 16.0, bottom: 0.0, right: 16.0)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .systemBackground
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.register(RankingCollectionViewCell.self, forCellWithReuseIdentifier: "RankingCollectionViewCell")
        
        return collectionView
    }()
    
    private let separatorView = SeparatorView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RankingFeatureSectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RankingCollectionViewCell", for: indexPath) as? RankingCollectionViewCell
        //cell.backgroundColor = .red
        cell?.setup()
        return cell ?? UICollectionViewCell()
    }
    
    
}

extension RankingFeatureSectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width-32.0, height: RankingCollectionViewCell.cellHeight)
    }
}

extension RankingFeatureSectionView {
    func setupViews() {
        [titleLabel, showAllAppsButton, collectionView, separatorView].forEach{ addSubview($0)}
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16.0)
            $0.top.equalToSuperview().inset(4.0)
            $0.trailing.equalTo(showAllAppsButton.snp.leading).offset(8.0)
        }
        showAllAppsButton.snp.makeConstraints{
            $0.trailing.equalToSuperview().inset(16.0)
            $0.bottom.equalTo(titleLabel.snp.bottom)
        }
        collectionView.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(16.0)
            $0.height.equalTo(RankingCollectionViewCell.cellHeight*3)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        separatorView.snp.makeConstraints{
            $0.top.equalTo(collectionView.snp.bottom).offset(16.0)
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
    }
}

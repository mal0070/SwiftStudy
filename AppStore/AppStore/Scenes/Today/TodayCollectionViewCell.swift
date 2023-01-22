//
//  TodayCollectionViewCell.swift
//  AppStore
//
//  Created by 이민아 on 2023/01/14.
//

import UIKit
import SnapKit
import Kingfisher

final class TodayCollectionViewCell: UICollectionViewCell {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24.0, weight: .bold)
        label.textColor = .white
        
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .bold)
        label.textColor = .white
        
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .bold)
        label.textColor = .white
        
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true //subview가 view의 경계를 넘어갈 시 둥글게 잘림
        imageView.layer.cornerRadius = 12.0
        imageView.backgroundColor = .gray
        
        return imageView
    }()
    
    func setup(today: Today){
        setupSubViews()
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 10
        
        /*subtitleLabel.text = "서브타이틀"
         descriptionLabel.text = "설명설명"
         titleLabel.text = "앱의 이름"*/
        subtitleLabel.text = today.subTitle
        descriptionLabel.text = today.description
        titleLabel.text = today.title
        
        if let imageURL = URL(string: today.imageURL){ //url은 초기화 리턴 값이 옵셔널 -> 사용할 때 옵셔널 체이닝 필요
            //옵셔널이 아니면
            imageView.kf.setImage(with: imageURL)
        }
    }
}
    
private extension TodayCollectionViewCell {
        func setupSubViews() {
            [imageView, titleLabel, subtitleLabel, descriptionLabel].forEach{ addSubview($0)}
            
            subtitleLabel.snp.makeConstraints{
                $0.leading.equalToSuperview().inset(24.0)
                $0.trailing.equalToSuperview().inset(24.0)
                $0.top.equalToSuperview().inset(24.0)
            }
            
            titleLabel.snp.makeConstraints{
                $0.leading.equalTo(subtitleLabel)
                $0.trailing.equalTo(subtitleLabel)
                $0.top.equalTo(subtitleLabel.snp.bottom).offset(4.0)
            }
            
            descriptionLabel.snp.makeConstraints{
                $0.leading.equalToSuperview().inset(24.0)
                $0.trailing.equalToSuperview().inset(24.0)
                $0.bottom.equalToSuperview().inset(24.0)
            }
            
            imageView.snp.makeConstraints{
                $0.edges.equalToSuperview() //셀의 사이즈와 똑같으므로
            }
        }
}


//
//  FeedTableViewCell.swift
//  Outstargram
//
//  Created by 이민아 on 2022/07/27.
//

import UIKit
import SnapKit


final class FeedTableViewCell: UITableViewCell {
    private lazy var postimageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .tertiaryLabel
        return imageView
    }()
    
    private lazy var likeButton: UIButton = {
        let button = UIButton()
        //button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.setImage(systemName: "heart")
        return button
    }()
    
    private lazy var commentButton: UIButton = {
        let button = UIButton()
        //button.setImage(UIImage(systemName: "message"), for: .normal)
        button.setImage(systemName: "message")
        return button
    }()
    private lazy var directMessageButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "paperplane"), for: .normal)
        
        return button
    }()
    private lazy var bookmarkButton: UIButton = {
        let button = UIButton()
        button.setImage(systemName: "bookmark")
        
        return button
    }()
    
    private lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 13.0, weight: .medium)
        label.numberOfLines = 5
        label.text = "Got me looking for attention 널 우연히 마주친 척할래 못 본 척 지나갈래 You’re so fine Gotta gotta get to know ya 나와 나와 걸어가 줘 지금 돌아서면 I need ya, need ya, need ya To look at me back Hey, 다 들켰었나 널 보면 하트가 튀어나와 난 사탕을 찾는 baby (Baby) 내 맘은 설레이지"
        
        return label
    }()
    
    private lazy var currentLikedCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 13.0, weight: .semibold)
        label.text = "이혜인 님 외 32명이 좋아합니다"
        
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 11.0, weight: .medium)
        label.text = "1일전"
        
        return label
    }()
    
    
    func setUp(){
        [ postimageView,
          likeButton,
          commentButton,
          directMessageButton,
          bookmarkButton,
          currentLikedCountLabel,
          contentLabel,
          dateLabel].forEach {addSubview($0)} //나중에 수정하기 쉽게 하기 위해, (코드 반복 막음) 배열에 컴포넌트 추가
        
        postimageView.snp.makeConstraints{
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.top.equalToSuperview()
            $0.height.equalTo(postimageView.snp.width)
        }
        let buttonWidth: CGFloat = 24.0
        let buttonInset: CGFloat = 16.0 //버튼 끼리 계속 간격 동일해야하므로 상수로 지정
        
        likeButton.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(buttonInset)
            $0.top.equalTo(postimageView.snp.bottom).offset(buttonInset)
            $0.width.equalTo(buttonWidth)
            $0.height.equalTo(buttonWidth)
            
        }
        
        commentButton.snp.makeConstraints{
            $0.leading.equalTo(likeButton.snp.trailing).offset(12.0)
            $0.top.equalTo(likeButton.snp.top)
            $0.width.equalTo(buttonWidth)
            $0.height.equalTo(buttonWidth)
        }
        
        directMessageButton.snp.makeConstraints{
            $0.leading.equalTo(commentButton.snp.trailing).offset(12.0)
            $0.top.equalTo(likeButton.snp.top)
            $0.width.equalTo(buttonWidth)
            $0.height.equalTo(buttonWidth)
        }
        
        bookmarkButton.snp.makeConstraints{
            $0.trailing.equalToSuperview().inset(buttonInset)
            $0.top.equalTo(likeButton.snp.top)
            $0.width.equalTo(buttonWidth)
            $0.height.equalTo(buttonWidth)
        }
        
        currentLikedCountLabel.snp.makeConstraints{
            $0.leading.equalTo(likeButton.snp.leading)
            $0.trailing.equalTo(bookmarkButton.snp.trailing)
            $0.top.equalTo(likeButton.snp.bottom).offset(14.0)
        }
        
        contentLabel.snp.makeConstraints{
            $0.leading.equalTo(likeButton.snp.leading)
            $0.trailing.equalTo(bookmarkButton.snp.trailing)
            $0.top.equalTo(currentLikedCountLabel.snp.bottom).offset(8.0)
        }
        
        dateLabel.snp.makeConstraints{
            $0.leading.equalTo(likeButton.snp.leading)
            $0.trailing.equalTo(bookmarkButton.snp.trailing)
            $0.top.equalTo(contentLabel.snp.bottom).offset(8.0)
            $0.bottom.equalToSuperview().inset(16.0)
        }
    }

}

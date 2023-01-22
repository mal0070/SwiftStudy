//
//  AppDetailViewController.swift
//  AppStore
//
//  Created by 이민아 on 2023/01/22.
//

import UIKit
import SnapKit
import Kingfisher

final class AppDetailViewController: UIViewController {
    private let today: Today //이걸 갖고 있어야 today에서 클릭 동작 연동 가능 -> init 필요 -> today 라는 값을 늘 가지고 있다
    
    private let appIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8.0
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20.0, weight: .bold)
        label.textColor = .label
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .medium)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let downloadButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 13.0, weight: .bold)
        button.setTitle("받기", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12.0
        
        return button
    }()
    
    private let sharedButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        button.tintColor = .systemBlue
        
        return button
    }()
    
    
    init(today: Today) {
        self.today = today
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground //darkmode!! 일때 배경색 자동으로 바뀜
        setupViews()
        
        /*appIconImageView.backgroundColor = .lightGray
        titleLabel.text = "title"
        subTitleLabel.text = "subtitle"
         */
        
        titleLabel.text = today.title
        subTitleLabel.text = today.subTitle
        if let imageURL = URL(string: today.imageURL){
            appIconImageView.kf.setImage(with: imageURL)
        }
    }



}

private extension AppDetailViewController{
    func setupViews(){
        [appIconImageView,titleLabel,subTitleLabel,downloadButton,sharedButton].forEach{view.addSubview($0)}
        
        appIconImageView.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(16.0)
            $0.top.equalToSuperview().inset(32.0)
            $0.height.equalTo(100.0)
            $0.width.equalTo(appIconImageView.snp.height)
        }
        titleLabel.snp.makeConstraints{
            $0.top.equalTo(appIconImageView.snp.top)
            $0.leading.equalTo(appIconImageView.snp.trailing).offset(16.0)
            $0.trailing.equalToSuperview().inset(16.0)
        }
        subTitleLabel.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(4.0)
            $0.leading.equalTo(titleLabel.snp.leading)
        }
        downloadButton.snp.makeConstraints{
            $0.bottom.equalTo(appIconImageView.snp.bottom)
            $0.height.equalTo(24.0)
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.width.equalTo(60.0)
        }
        sharedButton.snp.makeConstraints{
            $0.trailing.equalToSuperview().inset(16.0)
            $0.bottom.equalTo(downloadButton.snp.bottom)
            $0.width.equalTo(32.0)
            $0.height.equalTo(32.0)
        }
    }
}

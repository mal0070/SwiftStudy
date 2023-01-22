//
//  SeperateView.swift
//  AppStore
//
//  Created by 이민아 on 2023/01/20.
//

import SnapKit
import UIKit

final class SeparatorView: UIView { //원래 section 지정하면 자동으로 생기는데, 여기서는 section 1개니까 임의로 만듬
    private lazy var separator: UIView = {
        let separator = UIView()
        separator.backgroundColor = .separator
        return separator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(separator)
        separator.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(16.0)
            $0.trailing.equalToSuperview()
            $0.top.equalToSuperview()
            $0.height.equalTo(0.5)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

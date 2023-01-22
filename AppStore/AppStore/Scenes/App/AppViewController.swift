//
//  AppViewController.swift
//  AppStore
//
//  Created by 이민아 on 2023/01/20.
//

import SnapKit
import UIKit

final class AppViewController: UIViewController {
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical //세로 스크롤
        
        stackView.distribution = .equalSpacing //각각의 간격이 동일하게
        stackView.spacing = 0.0 //subView가 자유롭게 높이를 정하게 됨
        
        let featureSectionView = FeatureSectionView(frame: .zero) //init
        let rankingFeatureSectionView = RankingFeatureSectionView(frame: .zero)
        let exchangeCodeButtonView = ExchangeCodeButtonView(frame: .zero)
        
        //exchangeCodeButtonView.backgroundColor = .yellow
        
        let spacingView = UIView() //버튼 밑에 공간 주기 위해
        spacingView.snp.makeConstraints{
            $0.height.equalTo(100.0)
        }
        
        [featureSectionView, rankingFeatureSectionView, exchangeCodeButtonView, spacingView].forEach{
            stackView.addArrangedSubview($0)
        }
        
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationController()
        setupLayout()
    }
}

private extension AppViewController {
    func setupNavigationController(){
        navigationItem.title = "앱"
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true //large
    }
    func setupLayout(){
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top) //navigation bar 위를 넘어가게 하지 않기 위해
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints{
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview() //width고정 - 세로 스크롤. <=> height 고정 - 가로스크롤
        }
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints{
            $0.edges.equalToSuperview()
            //height은 subview에 따라 달라질 것이기 때문에 지정하면 안됨
        }
    }
}

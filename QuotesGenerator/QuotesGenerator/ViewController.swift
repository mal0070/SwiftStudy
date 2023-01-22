//
//  ViewController.swift
//  QuotesGenerator
//
//  Created by 이민아 on 2022/08/23.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    private lazy var mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        
        return view
    }()
    
    private lazy var quoteLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        //label.text = "편견이란 실효성 없는 의견이다."
        label.font = .systemFont(ofSize: 15.0, weight: .regular)
        
        return label
    }()
    
    private lazy var nameLabel : UILabel = {
       let label = UILabel()
        label.textColor = .label
        //label.text = "암브로스 밀"
        label.font = .systemFont(ofSize: 15.0, weight: .bold)
        
        return label
    }()
    
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("명언 생성", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15.0)
        button.addTarget(self, action: #selector(tapQuoteGeneratorButton), for: .touchUpInside)
        
        return button
    }()
    
    
    let quotes = [
        Quote(contents: "죽음을 두려워하는 나머지 삶을 시작조차 못하는 사람이 많다", name: "벤 다이크"),
        Quote(contents: "나는 나 자신을 빼 놓고는 모두 안다.", name: "비용"),
        Quote(contents: "편견이란 실효성 없는 의견이다.", name: "암브로스 밀"),
        Quote(contents: "분노는 바보들의 가슴 속에서만 살아간다.", name: "아인슈타인"),
        Quote(contents: "몇 번이라도 좋다! 이 끔찍한 생이여.... 다시!", name: "니체")
    ]
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "명언 생성기"
        
        [mainView, button].forEach{view.addSubview($0)}
        mainView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(24)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(200)
        }
        
        button.snp.makeConstraints{
            $0.top.equalTo(mainView.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
        setupLayOutOfQuote()
        
        
    }

}

extension ViewController{
    private func setupLayOutOfQuote(){
        [quoteLabel,nameLabel].forEach{mainView.addSubview($0)}
        quoteLabel.snp.makeConstraints{
            $0.top.equalToSuperview().inset(30)
            $0.centerX.equalToSuperview()
        }
        nameLabel.snp.makeConstraints{
            $0.top.equalTo(quoteLabel.snp.bottom).offset(40)
            $0.centerX.equalToSuperview()
        }
    }
    
    @objc func tapQuoteGeneratorButton(){
        let random = Int(arc4random_uniform(5)) //0~4사이의 난수
        let quote = quotes[random]
        self.quoteLabel.text = quote.contents
        self.nameLabel.text = quote.name
        
    }
}



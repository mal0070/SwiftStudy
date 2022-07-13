//
//  ViewController.swift
//  AutoLayout_code
//
//  Created by 이민아 on 2022/07/13.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    //1. UI요소 정의하기
           let nameLabel = UILabel()
           let nameTextField = UITextField()
           let changeButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpValue()
        setUpView()
        setConstraints()
    }
    //요소 내용 설정
    func setUpValue(){
        nameLabel.text = "코드로 만들기"
        nameTextField.backgroundColor = .green
        changeButton.backgroundColor = .blue
    }
    //2.View에 추가
    func setUpView(){
            view.addSubview(nameLabel)
            view.addSubview(nameTextField)
            view.addSubview(changeButton)
    }
        
    //3.AutoLayOut -> 여기서 SnapKit 이용
    func setConstraints(){
            changeButton.snp.makeConstraints{ make in
                make.center.equalToSuperview() //view의 정중앙에 배치
        }
            
            nameLabel.snp.makeConstraints{ make in
                make.top.equalToSuperview().offset(80)
                make.leading.equalToSuperview().offset(24)
                make.trailing.equalToSuperview().offset(-24)
        }
            nameTextField.snp.makeConstraints{ make in
                make.top.equalTo(nameLabel.snp.bottom).offset(24)
                make.leading.trailing.equalTo(nameLabel) //값이 중복될 경우 한번에 작성 가능
                
        }
    }
        
        
}





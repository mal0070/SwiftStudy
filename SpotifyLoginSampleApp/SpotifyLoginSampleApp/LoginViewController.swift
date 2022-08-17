//
//  LoginViewController.swift
//  SpotifyLoginSampleApp
//
//  Created by 이민아 on 2022/08/13.
//

import UIKit

class LoginViewController: UIViewController{
    @IBOutlet weak var emailLoginButton: UIButton!
    @IBOutlet weak var googleLoginButton: UIButton!
    @IBOutlet weak var appleLoginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        [emailLoginButton, googleLoginButton, appleLoginButton].forEach{ //반복문
            $0?.layer.borderWidth = 1
            $0?.layer.borderColor = UIColor.white.cgColor
            $0?.layer.cornerRadius = 30
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //navigation bar 숨기는 코드. 근데 이제 업데이트버전에서는 기본설정으로 숨겨져 있는듯
        navigationController?.navigationBar.isHidden = true
    }
    
    
    @IBAction func googleLoginTapped(_ sender: Any) {
        //firebase
    }
    
    @IBAction func appleLoginTapped(_ sender: Any) {
        //firebase
    }
}

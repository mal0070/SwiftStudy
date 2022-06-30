//
//  ViewController.swift
//  OddorEvenGame
//
//  Created by 이민아 on 2022/07/01.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var userBallCountLb: UILabel!
    @IBOutlet weak var computerBallCountLb: UILabel!
    
    var comBallsCount: Int = 20
    var userBallsCount: Int = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        computerBallCountLb.text = String(comBallsCount) //int를 string으로 타입캐스팅(형변환)
        userBallCountLb.text = String(userBallsCount)
    }

    @IBAction func gameStartPressed(_ sender: Any) {
        print("게임시작")
    }
    
}


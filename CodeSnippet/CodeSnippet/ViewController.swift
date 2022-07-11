//
//  ViewController.swift
//  CodeSnippet
//
//  Created by 이민아 on 2022/07/11.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        
        let color = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        let black = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        let green = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        let white = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        switch color {
        case black:
            print("black")
        case green:
            print("green")
        case white:
            print("white")
        default:
            print("default")
        }
        
    }


}


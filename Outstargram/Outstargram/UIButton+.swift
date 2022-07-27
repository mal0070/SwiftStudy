//
//  UIButton+.swift
//  Outstargram
//
//  Created by 이민아 on 2022/07/27.
//

import SnapKit
import UIKit

extension UIButton{
    func setImage(systemName: String){
        contentHorizontalAlignment = .fill
        contentVerticalAlignment = .fill
        
        imageView?.contentMode = .scaleAspectFit
        //imageEdgeInsets = .zero <-ios15에서 권장하지 않음
        
        setImage(UIImage(systemName: systemName), for: .normal)
        
    }
}


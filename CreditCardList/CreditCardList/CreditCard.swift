//
//  CreditCard.swift
//  CreditCardList
//
//  Created by 이민아 on 2022/08/18.
//

import Foundation

struct CreditCard: Codable {
    let id: Int
    let rank : Int
    let name: String
    let cardImgURL: String
    let promotionDetail: PromotionDetail
    let isSelected: Bool? //추가. 선택되었을 때 동작 구현 위해! 선택 안할 수 도 있으므로 옵셔널
}

struct PromotionDetail: Codable{
    let companyName: String
    let period: String
    let amount: Int
    let condition: String
    let benefitCondition: String
    let benefitDetail: String
    let benefitDate: String
}

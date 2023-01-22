//
//  Ranking.swift
//  AppStore
//
//  Created by 이민아 on 2023/01/22.
//

import Foundation

struct RankingFeature : Decodable {
    let title: String
    let description: String
    let isInPurchaseApp: Bool
}

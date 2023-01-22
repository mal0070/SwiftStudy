//
//  Feature.swift
//  AppStore
//
//  Created by 이민아 on 2023/01/22.
//

import Foundation

struct Feature: Decodable {
    let type: String
    let appName: String
    let description: String
    let imageURL: String
}

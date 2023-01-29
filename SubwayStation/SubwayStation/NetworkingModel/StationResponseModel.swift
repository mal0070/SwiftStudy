//
//  StationResponseModel.swift
//  SubwayStation
//
//  Created by 이민아 on 2023/01/28.
//

import Foundation

struct StationResponseModel : Decodable {
    var stations: [Station] { searchInfo.row } //StationResponseModel().searchInfo.row 쓸 때 귀찮아서 정의함 => StationResponseModel().stations
    
    private let searchInfo: SearchInfoBySubwayNameServiceModel
    
    enum CodingKeys: String, CodingKey {
        case searchInfo = "SearchInfoBySubwayNameService"
    }
    
    
    //복잡할 땐 하위부터 작성
    struct SearchInfoBySubwayNameServiceModel: Decodable {
        var row: [Station] = []
    }
}

struct Station: Decodable {
    let stationName: String
    let lineName: String
    
    enum CodingKeys: String, CodingKey { //이름 맘대로 수정해서 enum작성(실제이름)
        case stationName = "STATION_NM"
        case lineName = "LINE_NUM"
    }
}

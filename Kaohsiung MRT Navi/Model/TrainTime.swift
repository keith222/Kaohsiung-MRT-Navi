//
//  TrainTime.swift
//  Kaohsiung MRT Navi
//
//  Created by Yang Tun-Kai on 2023/1/17.
//

import Foundation

struct TrainTime: Codable {
    
    let lineID: String
    let stationID: String
    let destinationStationID: String
    let serviceStatus: ServiceStatus
    let estimateTime: Int?
    
    enum CodingKeys: String, CodingKey {
        case lineID = "LineID"
        case stationID = "StationID"
        case destinationStationID = "DestinationStationID"
        case serviceStatus = "ServiceStatus"
        case estimateTime = "EstimateTime"
    }
}

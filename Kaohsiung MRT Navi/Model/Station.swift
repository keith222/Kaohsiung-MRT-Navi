//
//  Station.swift/Users/Keith/Documents/My Project/Kaohsiung MRT Navi/Kaohsiung MRT Navi/Data/zh-Hant.lproj/Localizable.strings
//  Kaohsiung MRT Navi
//
//  Created by Yang Tun-Kai on 2022/12/27.
//

import Foundation

struct Station: Codable {
    let num: String
    let station: String
    let stationEN: String
    let stationJP: String
    let stationKR: String
    let stationSCHI: String
    let geoHash: String
    let toilet: [Int]?
    let elevator: [Int]?
    let escalatorUp: [Int]?
    let escalatorDown: [Int]?
    let bicycle: [Int]?
    let exit: [String]?
    let exitInfo: [String]?
    
    enum CodingKeys: String, CodingKey {
        case num = "Num"
        case station = "Station"
        case stationEN = "Station_Eng"
        case stationJP = "Station_Jpn"
        case stationKR = "Station_Kor"
        case stationSCHI = "Station_SChi"
        case geoHash = "GeoHash"
        case toilet = "Toilet"
        case elevator = "Elevator"
        case escalatorUp = "EscalatorUp"
        case escalatorDown = "EscalatorDown"
        case bicycle = "Bicycle"
        case exit = "Exit"
        case exitInfo = "ExitInfo"
    }
}

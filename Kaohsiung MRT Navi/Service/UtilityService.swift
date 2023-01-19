//
//  UtilityService.swift
//  Kaohsiung MRT Navi
//
//  Created by Yang Tun-Kai on 2023/1/18.
//

import Foundation

final class UtilityService {
    
    static func getName(of station: Station?) -> String {
        guard let station = station else { return "" }
        
        if let code = Locale.autoupdatingCurrent.language.languageCode, let script = Locale.autoupdatingCurrent.language.script {
            switch code {
            case .english: return station.stationEN
            case .chinese: return (script == .hanTraditional) ? station.station : station.stationSCHI
            case .japanese: return station.stationJP
            case .korean: return station.stationKR
            default: return station.station
            }
        }
        
        return station.station
    }
}

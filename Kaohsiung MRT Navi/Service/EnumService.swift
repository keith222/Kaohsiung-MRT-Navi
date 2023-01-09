//
//  EnumService.swift
//  Kaohsiung MRT Navi
//
//  Created by Yang Tun-Kai on 2023/1/6.
//

import Foundation
import SwiftUI

enum TransformationCategory: String {
    case thsr
    case tra
    case youbike
    case airport
    case redLine
    case orangeLine
    case lrt
    
    var title: String {
        return self.rawValue.localized()
    }
    
    var backgroundColor: Color {
        switch self {
        case .thsr: return .thsrColor
        case .tra: return .traColor
        case .youbike: return .youbikeColor
        case .airport: return .airportColor
        case .redLine: return .redLineColor
        case .orangeLine: return .orangeLineColor
        case .lrt: return .circleLineColor
        }
    }
    
    var icon: String {
        switch self {
        case .thsr: return "ꀻ"
        case .tra: return "ꁡ"
        case .youbike: return "ꀽ"
        case .airport: return "airplane"
        case .redLine: return "R"
        case .orangeLine: return "O"
        case .lrt: return "C"
        }
    }
}

enum EscalatorCategory: String {
    case up = "escalatorUp"
    case down = "escalatorDown"
}

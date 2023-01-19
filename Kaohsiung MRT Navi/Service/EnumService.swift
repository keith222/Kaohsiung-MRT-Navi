//
//  EnumService.swift
//  Kaohsiung MRT Navi
//
//  Created by Yang Tun-Kai on 2023/1/6.
//

import Foundation
import SwiftUI

enum RouteLine: String, Equatable {
    case red = "Red"
    case orange = "Orange"
    case circle = "Circle"
}

enum ServiceStatus: Int, CaseIterable, Codable {
    case inService, notYetStart, noStop, lastTrainPassed, notInService
    
    var description: String {
        switch self {
        case .inService: return StringConstant.inService
        case .notYetStart: return StringConstant.notYetStart
        case .noStop: return StringConstant.noStop
        case .lastTrainPassed: return StringConstant.lastTrainPassed
        case .notInService: return StringConstant.notInService
        }
    }
}

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

enum HttpMethod: String {
    case `get` = "GET"
    case post = "POST"
}

enum NetworkError: Error {
    case invalidURL
    case requestFailed(Error)
    case invalidData
    case invalidResponse
    case unexpectedStatusCode
    case pageNotFound
}

extension NetworkError: LocalizedError {
    
    var errorDescription: String? {
            switch self {
            case .invalidURL: return StringConstant.invalidURL.localizedLowercase
            case .requestFailed(let error): return error.localizedDescription
            case .invalidData: return StringConstant.invalidData.localizedLowercase
            case .invalidResponse: return StringConstant.invalidResponse.localizedLowercase
            case .unexpectedStatusCode: return StringConstant.unexpectedStatusCode.localizedLowercase
            case .pageNotFound: return StringConstant.pageNotFound.localizedLowercase
            }
        }
}

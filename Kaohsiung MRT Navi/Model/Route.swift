//
//  Route.swift
//  Kaohsiung MRT Navi
//
//  Created by Yang Tun-Kai on 2022/12/29.
//

import Foundation

struct Route: Codable {
    let red: [Station]
    let orange: [Station]
    let circle: [Station]
    
    enum CodingKeys: String, CodingKey, Equatable {
        case red = "Red"
        case orange = "Orange"
        case circle = "Circle"
    }
}

struct RouteRepository {
    
    static func getStationList(of route: Route.CodingKeys) -> [Station] {
        guard let routes = RouteService.shared.routes else { return [] }
        
        switch route {
        case .red: return routes.red
        case .orange: return routes.orange
        case .circle: return routes.circle
        }
    }
    
    static func getPolyLine(of route: Route.CodingKeys) -> String {
        switch route {
        case .red: return RouteService.shared.redLine
        case .orange: return RouteService.shared.orangeLine
        case .circle: return RouteService.shared.circleLine
        }
    }
    
    static func getRouteName(of route: Route.CodingKeys) -> String {
        switch route {
        case .red: return "redLine".localized()
        case .orange: return "orangeLine".localized()
        case .circle: return "circleLine".localized()
        }
    }
    
    static func getImageName(with route: Route.CodingKeys) -> String {
        switch route {
        case .red: return ImageConstant.redLine
        case .orange: return ImageConstant.orangeLine
        case .circle: return ImageConstant.circleLine
        }
    }
    
    static func getStartStation(of route: Route.CodingKeys) -> String {
        switch route {
        case .red: return "redLineStart".localized()
        case .orange: return "orangeLineStart".localized()
        case .circle: return "circleLineStart".localized()
        }
    }
    
    static func getTerminalStation(of route: Route.CodingKeys) -> String {
        switch route {
        case .red: return "redLineEnd".localized()
        case .orange: return "orangeLineEnd".localized()
        case .circle: return "circleLineEnd".localized()
        }
    }
}

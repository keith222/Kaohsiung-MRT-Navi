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

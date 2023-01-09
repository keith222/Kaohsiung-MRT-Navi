//
//  Transformation.swift
//  Kaohsiung MRT Navi
//
//  Created by Yang Tun-Kai on 2023/1/5.
//

import Foundation

struct Transformation: Codable {
    let system: String
    let line: String?
    let exit: Int?
    
    enum CodingKeys: String, CodingKey {
        case system = "System"
        case line = "Line"
        case exit = "Exit"
    }
}

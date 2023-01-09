//
//  StringExtension.swift
//  Kaohsiung MRT Navi
//
//  Created by Yang Tun-Kai on 2022/12/30.
//

import Foundation
import SwiftUI

extension String {
    
    func localized(comment: String = "") -> String {
        return NSLocalizedString(self, comment: comment)
    }
    
    func getIntersactionLine() -> String {
        switch self {
        case "o5", "c3", "c24": return "r"
        case "r6", "r13", "o1": return "c"
        case "c14", "r10": return "o"
        default: return "n"
        }
    }
    
    func getLineColor() -> Color {
        switch self {
        case "r": return .redLineColor
        case "o": return .orangeLineColor
        case "c": return .circleLineColor
        default: return .clear
        }
    }

}

//
//  StringExtension.swift
//  Kaohsiung MRT Navi
//
//  Created by Yang Tun-Kai on 2022/12/30.
//

import Foundation
import SwiftUI

extension String {
    
    var terminalStation: String {
        switch self {
        case "R3": return StringConstant.redLineStart
        case "R24": return StringConstant.redLineEnd
        case "O1": return StringConstant.orangeLineStart
        case "OT1": return StringConstant.orangeLineEnd
        case "C24": return StringConstant.circleLineStart
        case "C32": return StringConstant.circleLineEnd
        default: return "--"
        }
    }
    
    var lineColor: Color {
        switch self {
        case "r": return .redLineColor
        case "o": return .orangeLineColor
        case "c": return .circleLineColor
        default: return .clear
        }
    }
    
    var intersactionLine: String {
        switch self {
        case "o5", "c3", "c24": return "r"
        case "r6", "r13", "o1": return "c"
        case "c14", "r10": return "o"
        default: return "n"
        }
    }
    
    func localized(comment: String = "") -> String {
        return NSLocalizedString(self, comment: comment)
    }
}

//
//  StationCellViewModel.swift
//  Kaohsiung MRT Navi
//
//  Created by Yang Tun-Kai on 2022/12/30.
//

import Foundation
import SwiftUI

struct StationCellViewModel: Hashable {
    
    let stationNum: String
    let stationName: String
    let stationSubName: String
    
    var imageName: String {
        var name = ImageConstant.station
        switch stationNum {
        case "r6": name += "cr6"
        case "r10": name += "or10"
        case "r13": name += "cr13"
        case "o1": name += "co1"
        case "o5": name += "ro5"
        case "c3": name += "rc3"
        case "c14": name += "oc14"
        case "c24": name += "rc24"
        default: name += stationNum
        }
        
        return name
    }
    
    private func checkIsStart() -> Bool {
        return stationNum == "r3" || stationNum == "o1" || stationNum == "c1"
    }
    
    private func checkIsTerminal() -> Bool {
        return stationNum == "r24" || stationNum == "ot1" || stationNum == "c37"
    }
            
    func checkIsIntersactionStation() -> Bool {
        return stationNum.intersactionLine != "n"
    }
    
    func createVerticalLineViewModel() -> LineViewModel {
        return LineViewModel(color: (stationNum.first ?? "n").lowercased().lineColor, isStart: checkIsStart(), isTerminal: checkIsTerminal(), isCircle: ((stationNum.first ?? "n").lowercased() == "c"))
    }
    
    func createHorizontalLineViewModel() -> LineViewModel {
        return LineViewModel(color: stationNum.intersactionLine.lineColor, isStart: false, isTerminal: false)
    }
}

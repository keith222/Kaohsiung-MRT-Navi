//
//  PlaceAnnotationViewModel.swift
//  Kaohsiung MRT Navi
//
//  Created by Yang Tun-Kai on 2023/1/8.
//

import Foundation
import SwiftUI
import CoreLocation

struct PlaceAnnotationViewModel {
    
    let stationNum: String
    let exit: Int
    
    var imageName: String {
        return ImageConstant.station + stationNum.lowercased()
    }
    
    var color: Color {
        return (stationNum.first ?? "n").lowercased().lineColor
    }
    
    var exitText: String {
        return "\(StringConstant.exit)\(exit)"
    }
}

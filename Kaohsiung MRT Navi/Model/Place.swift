//
//  Place.swift
//  Kaohsiung MRT Navi
//
//  Created by Yang Tun-Kai on 2023/1/8.
//

import Foundation
import CoreLocation

struct Place: Identifiable {
    
    let id = UUID()
    let stationNum: String
    let coordinate: CLLocationCoordinate2D
    var exit: Int = 0
}

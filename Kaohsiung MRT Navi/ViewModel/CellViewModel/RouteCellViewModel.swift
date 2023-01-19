//
//  RouteListCellViewModel.swift
//  Kaohsiung MRT Navi
//
//  Created by Yang Tun-Kai on 2022/12/29.
//

import Foundation

struct RouteCellViewModel: Hashable {
    
    let routeName: String
    let routeStartStation: String
    let routeTerminalStation: String
    let routeImageName: String
    let routeKey: RouteLine
}

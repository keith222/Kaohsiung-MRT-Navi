//
//  RouteListViewModel.swift
//  Kaohsiung MRT Navi
//
//  Created by Yang Tun-Kai on 2022/12/30.
//

import Foundation

@MainActor class RouteListViewModel: ObservableObject {
    
    @Published private(set) var title: String = StringConstant.routeList
    @Published private(set) var polyLines: [RouteLine: String] = [.red: RouteService.shared.redLine, .orange: RouteService.shared.orangeLine, .circle: RouteService.shared.circleLine]
    @Published private(set) var routeCellViewModels: [RouteCellViewModel] = []
    @Published var selection: Int = 0
    
    init() {
        loadCellViewModels()
    }
    
    func createStationListViewModel(with route: RouteLine) -> StationListViewModel {
        return StationListViewModel(with: route)
    }
    
    private func loadCellViewModels() {
        var viewModels = [RouteCellViewModel]()
        for index in 0..<3 {
            viewModels.append(createCellViewModel(with: index))
        }
        routeCellViewModels.append(contentsOf: viewModels)
    }
    
    private func createCellViewModel(with index: Int) -> RouteCellViewModel {
        var routeName = ""
        var routeStartStation = ""
        var routeTerminalStation = ""
        var routeImageName = ""
        var routeKey = RouteLine.red
        
        switch index {
        case 0:
            routeName = StringConstant.redLine
            routeStartStation = StringConstant.redLineStart
            routeTerminalStation = StringConstant.redLineEnd
            routeImageName = ImageConstant.redLine
            routeKey = .red
        case 1:
            routeName = StringConstant.orangeLine
            routeStartStation = StringConstant.orangeLineStart
            routeTerminalStation = StringConstant.orangeLineEnd
            routeImageName = ImageConstant.orangeLine
            routeKey = .orange
        case 2:
            routeName = StringConstant.circleLine
            routeStartStation = StringConstant.circleLineStart
            routeTerminalStation = StringConstant.circleLineEnd
            routeImageName = ImageConstant.circleLine
            routeKey = .circle
        default:
            break
        }
        
        return RouteCellViewModel(routeName: routeName, routeStartStation: routeStartStation, routeTerminalStation: routeTerminalStation, routeImageName: routeImageName, routeKey: routeKey)
    }
}

//
//  StationListViewModel.swift
//  Kaohsiung MRT Navi
//
//  Created by Yang Tun-Kai on 2022/12/30.
//

import Foundation

@MainActor class StationListViewModel: ObservableObject {
    
    private let route: RouteLine
    private var stations: [Station] = []
    private var originalStationCellViewModels: [StationCellViewModel] = []
    
    @Published private(set) var title: String = StringConstant.stationList
    @Published private(set) var stationCellViewModels: [StationCellViewModel] = [] 
    @Published var searchText = ""
    
    init(with route: RouteLine) {
        self.route = route
        loadStationList()
    }
    
    func createStationDetailData(with index: Int) -> StationDetailViewModel {
        return StationDetailViewModel(with: stations[index])
    }
    
    private func loadStationList() {
        switch route {
        case .red: stations = RouteService.shared.routes?.red ?? []
        case .orange: stations = RouteService.shared.routes?.orange ?? []
        case .circle: stations = RouteService.shared.routes?.circle ?? []
        }
        processLoaded(stations)
    }
    
    func searchStation(with searchText: String) {
        stationCellViewModels = searchText.isEmpty ? originalStationCellViewModels : originalStationCellViewModels.filter{ $0.stationName.contains(searchText) || $0.stationSubName.contains(searchText)}
    }
    
    private func processLoaded(_ stations: [Station]) {
        var viewModels = [StationCellViewModel]()
        for station in stations {
            viewModels.append(createCellViewModel(with: station))
        }
        originalStationCellViewModels.append(contentsOf: viewModels)
        stationCellViewModels = originalStationCellViewModels
    }
    
    private func createCellViewModel(with station: Station) -> StationCellViewModel {
        let stationName = UtilityService.getName(of: station)
        let stationSubName = (Locale.autoupdatingCurrent.language.languageCode == .some(.chinese)) ? station.stationEN : station.station
        
        return StationCellViewModel(stationNum: station.num.lowercased(), stationName: stationName, stationSubName: stationSubName)
    }
}

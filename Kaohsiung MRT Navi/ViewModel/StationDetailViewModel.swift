//
//  StationDetailViewModel.swift
//  Kaohsiung MRT Navi
//
//  Created by Yang Tun-Kai on 2023/1/5.
//

import Foundation

@MainActor class StationDetailViewModel: ObservableObject {
    
    private let station: Station
    
    private var geoHash: String {
        return station.geoHash
    }
    
    private var exitGeoHash: [String] {
        return station.exit ?? []
    }
    
    private var toilets: [Int] {
        return station.toilet ?? []
    }
    
    private var bicyclePoints: [Int] {
        return station.bicycle ?? []
    }
    
    private var elevator: [Int] {
        return station.elevator ?? []
    }
    
    private var escalatorUp: [Int] {
        return station.escalatorUp ?? []
    }
    
    private var escalatorDown: [Int] {
        return station.escalatorDown ?? []
    }

    private var hasBicyclePoint: Bool {
        guard let point = station.bicycle else { return false }
        return !point.isEmpty
    }
    
    private var hasAirport: Bool {
        return station.num == "R4"
    }
    
    private var hasTRA: Bool {
        guard let transformation = station.transformation else { return false }
        return transformation.contains(where: { $0.system == TransformationCategory.tra.rawValue.uppercased() })
    }
    
    private var hasTHSR: Bool {
        guard let transformation = station.transformation else { return false }
        return transformation.contains(where: { $0.system == TransformationCategory.thsr.rawValue.uppercased() })
    }
    
    private var hasLRT: Bool {
        guard let transformation = station.transformation else { return false }
        return transformation.contains(where: { $0.system == TransformationCategory.lrt.rawValue.uppercased() })
    }
    
    private var hasRed: Bool {
        guard let transformation = station.transformation else { return false }
        return transformation.contains(where: { $0.system == StringConstant.mrt && $0.line == .some(StringConstant.red) })
    }
    
    private var hasOrange: Bool {
        guard let transformation = station.transformation else { return false }
        return transformation.contains(where: { $0.system == StringConstant.mrt && $0.line == .some(StringConstant.orange) })
    }
    
    @Published private(set) var stationImageName: String = ""
    @Published private(set) var stationName: String = ""
    @Published private(set) var stationSubName: String = ""
    @Published private(set) var isSaved: Bool = false
    @Published private(set) var tagViewModels: [TagViewModel] = []
    @Published private(set) var exitInfoViewModels: [ExitInfoViewModel] = []
    @Published var showSheet: Bool = false
    
    init(with station: Station) {
        self.station = station
        
        initUIData()
        createTransformationTagViewModels()
        loadExitInfoViewModels()
    }
    
    private func initUIData() {
        stationImageName = ImageConstant.station + station.num.lowercased()
        
        stationName = UtilityService.getName(of: station)
        stationSubName = (Locale.autoupdatingCurrent.language.languageCode == .some(.chinese)) ? station.stationEN : station.station        
    }
    
    private func createTransformationTagViewModels() {
        if hasTHSR {
            tagViewModels.append(TagViewModel(category: .thsr))
        }
        
        if hasTRA {
            tagViewModels.append(TagViewModel(category: .tra))
        }
        
        if hasAirport {
            tagViewModels.append(TagViewModel(category: .airport))
        }
        
        if hasBicyclePoint {
            tagViewModels.append(TagViewModel(category: .youbike))
        }
        
        if hasRed {
            tagViewModels.append(TagViewModel(category: .redLine))
        }
        
        if hasOrange {
            tagViewModels.append(TagViewModel(category: .thsr))
        }
        
        if hasOrange {
            tagViewModels.append(TagViewModel(category: .orangeLine))
        }
        
        if hasLRT {
            tagViewModels.append(TagViewModel(category: .lrt))
        }
    }
    
    private func loadExitInfoViewModels() {
        guard let exit = station.exit else { return }
        
        for i in 1...exit.count {
            exitInfoViewModels.append(createExitInfoViewModel(station: station, exitNum: i))
        }
    }
    
    private func createExitInfoViewModel(station: Station, exitNum: Int) -> ExitInfoViewModel {
        let info = station.exitInfo?[exitNum - 1] ?? ""
        var categories = [TransformationCategory]()
        var escalators = [EscalatorCategory]()
        
        if !bicyclePoints.isEmpty && bicyclePoints.contains(exitNum) {
            categories.append(.youbike)
        }
        
        if let transformation = station.transformation {
            if hasLRT && transformation.contains(where: { $0.exit == exitNum }) {
                categories.append(.lrt)
            }
            if hasTHSR && transformation.contains(where: { $0.exit == exitNum }) {
                categories.append(.thsr)
            }
            if hasTRA && transformation.contains(where: { $0.exit == exitNum }) {
                categories.append(.tra)
            }
        }
        
        if !escalatorUp.isEmpty && escalatorUp.contains(exitNum) {
            escalators.append(.up)
        }
        if !escalatorDown.isEmpty && escalatorDown.contains(exitNum) {
            escalators.append(.down)
        }
        
        let hasToilet = (!toilets.isEmpty && toilets.contains(exitNum))
        let hasElevator = (!elevator.isEmpty && elevator.contains(exitNum))
        
        return ExitInfoViewModel(exitNum: exitNum, info: info, categories: categories, hasElevator: hasElevator, hasToilet: hasToilet, escalator: escalators)
    }
    
    func getStationPlanURL() -> URL {
        let urlString = APIService.MRTMapURL.replacingOccurrences(of: "@", with: station.num)
        return URL(string: urlString)!
    }
    
    func checkIsCircleLine() -> Bool {
        return station.num.hasPrefix("C")
    }
    
    func createMapViewModel() -> StationMapViewModel {
        return StationMapViewModel(stationNum: station.num, geoHash: station.geoHash, exitGeoHash: station.exit)
    }
}

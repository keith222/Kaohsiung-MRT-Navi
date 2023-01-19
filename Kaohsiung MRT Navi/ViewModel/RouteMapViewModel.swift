//
//  RouteMapViewModel.swift
//  Kaohsiung MRT Navi
//
//  Created by Yang Tun-Kai on 2023/1/10.
//

import Foundation
import SwiftUI
import CoreLocation
import MapKit
import Polyline
import Combine

@MainActor class RouteMapViewModel: ObservableObject {
    
    private var region: MKCoordinateRegion
    private var stations: [Station] = []
    private var lines: [[CLLocationCoordinate2D]] = []
    private var timer: Timer?
    
    @Published private(set) var trainInfoViewModel: TrainInfoViewModel = TrainInfoViewModel()
    @Published private(set) var trainInfoViewModel2: TrainInfoViewModel = TrainInfoViewModel()
    @Published var showError: (result: Bool, message: String) = (false, "")
    @Published var isIntersaction: Bool = false
    @Published var offsetY: CGFloat = 800
    @Published var selectedAnnotation: Annotation? {
        didSet {
            if let annotation = selectedAnnotation {
                guard let id = annotation.id else { return }
                isIntersaction = (id == "R10")
                offsetY = 0
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8, execute: { [weak self] in
                    self?.startToGetTime(of: id)
                })
                
            } else {
                stopToGetTime()
                offsetY = 800
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8, execute: { [weak self] in
                    self?.isIntersaction = false
                    self?.resetTrainInfoUI()
                })
            }
        }
    }
    
    init() {
        region = MKCoordinateRegion(center: CLLocationCoordinate2D(geohash: "wsj8c93vb"), latitudinalMeters: 4500, longitudinalMeters: 4500)
        
        if let routes = RouteService.shared.routes {
            stations.append(contentsOf: routes.red)
            stations.append(contentsOf: routes.orange)
            stations.append(contentsOf: routes.circle)
        }
        
        let circleLine: [CLLocationCoordinate2D] = decodePolyline(RouteService.shared.circleLine) ?? []
        lines.append(circleLine)
        let orangeLine: [CLLocationCoordinate2D] = decodePolyline(RouteService.shared.orangeLine) ?? []
        lines.append(orangeLine)
        let redLine: [CLLocationCoordinate2D] = decodePolyline(RouteService.shared.redLine) ?? []
        lines.append(redLine)
        
    }
    
    func createMapViewModel() -> MapViewModel {
        return MapViewModel(region: region, lineCoordinates: lines, stations: stations)
    }
    
    func stopToGetTime() {
        timer?.invalidate()
    }
    
    private func startToGetTime(of stationNum: String) {
        if NetworkMonitorService.shared.isConnected {
            Task(priority: .background) {
                let checkToken = await APIService.checkToken()
                switch checkToken {
                case .success(_):
                    initTimer(with: stationNum)
                    
                case .failure(let error):
                    showError.result = false
                    showError.message = error.localizedDescription
                    print(error.localizedDescription)
                    
                }
            }
        }
    }
    
    private func initTimer(with stationNum: String) {
        Timer.scheduledTimer(timeInterval: 0, target: self, selector: #selector(fetchTime(sender:)), userInfo: stationNum, repeats: false)
        timer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(fetchTime(sender:)), userInfo: stationNum, repeats: true)
    }
    
    private func updateTrainInfoUI(with infos: [TrainTime]) {
        let name = UtilityService.getName(of: stations.first(where: { $0.num == infos[0].stationID }))
        let num = infos[0].stationID
        let arriveTime1 = "\(infos[0].estimateTime ?? 0)"
        let serviceStatus1 = infos[0].serviceStatus
        var terminal1 = infos[0].destinationStationID.terminalStation
        
        let arriveTime2 = "\(infos[1].estimateTime ?? 0)"
        let serviceStatus2 = infos[1].serviceStatus
        var terminal2 = infos[1].destinationStationID.terminalStation
        
        switch infos[0].stationID {
        case "R3":
            terminal1 = StringConstant.redLineEnd
            terminal2 = terminal1
        case "R24":
            terminal1 = StringConstant.redLineStart
            terminal2 = terminal1
        case "O1":
            terminal1 = StringConstant.orangeLineEnd
            terminal2 = terminal1
        case "OT1":
            terminal1 = StringConstant.orangeLineStart
            terminal2 = terminal1
        case "C24":
            terminal1 = StringConstant.circleLineStart
            terminal2 = terminal1
        case "C32":
            terminal1 = StringConstant.circleLineEnd
            terminal2 = terminal1
        default:
            break;
        }
        
        trainInfoViewModel.updateUI(with: num, name, terminal1, terminal2, arriveTime1, arriveTime2, and: serviceStatus1, serviceStatus2)
        
        guard infos.count == 4 else { return }
        
        let name2 = UtilityService.getName(of: stations.first(where: { $0.num == infos[0].stationID }))
        let num2 = infos[2].stationID
        let arriveTime21 = "\(infos[2].estimateTime ?? 0)"
        let serviceStatus21 = infos[2].serviceStatus
        let terminal21 = infos[2].destinationStationID.terminalStation
        
        let arriveTime22 = "\(infos[3].estimateTime ?? 0)"
        let serviceStatus22 = infos[3].serviceStatus
        let terminal22 = (infos[2].stationID == "R10") ? StringConstant.redLineEnd : infos[3].destinationStationID.terminalStation
        
        trainInfoViewModel2.updateUI(with: num2, name2, terminal21, terminal22, arriveTime21, arriveTime22, and: serviceStatus21, serviceStatus22)
    }
    
    private func resetTrainInfoUI() {
        trainInfoViewModel.resetUI()
        trainInfoViewModel2.resetUI()
    }
    
    @objc private func fetchTime(sender: Timer) {
        if let stationNum = sender.userInfo as? String {
            let system = stationNum.lowercased().hasPrefix("c") ? StringConstant.klrt : StringConstant.krtc
            let query = "$filter=StationID eq \((stationNum == "R10") ? "'R10' or StationID eq 'O5'" : "'\(stationNum)'")".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            let url = APIService.timeURL.replacingOccurrences(of: "@", with: system).appending(query)
            let header = ["Authorization": "Bearer \(UserDefaults().token ?? "")"]
            
            Task(priority: .background) {
                let result = await APIService.request(url, headers: header, responseModel: [TrainTime].self)
                switch result {
                case .success(let trainTimes):
                    guard !trainTimes.isEmpty else { return }
                    updateTrainInfoUI(with: trainTimes)
                    
                case .failure(let error):
                    stopToGetTime()
                    showError.result = true
                    showError.message = error.localizedDescription
                    print(error.localizedDescription)
                }
            }
        }
    }
}

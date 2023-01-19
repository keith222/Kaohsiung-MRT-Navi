//
//  TrainInfoViewModel.swift
//  Kaohsiung MRT Navi
//
//  Created by Yang Tun-Kai on 2023/1/11.
//

import Foundation
import SwiftUI

@MainActor class TrainInfoViewModel: ObservableObject {
    
    @Published private(set) var stationNum: String = "--" {
        didSet {
            imageName = (stationNum != "--") ? "\(ImageConstant.station)\(stationNum.lowercased())" : ""
        }
    }
    @Published private(set) var stationTimeViewModel: StationTimeViewModel = StationTimeViewModel()
    @Published private(set) var stationTimeViewModel2: StationTimeViewModel = StationTimeViewModel()
    @Published private(set) var stationName: String = "--"
    @Published private(set) var imageName: String = ""
        
    func resetUI() {
        stationNum = "--"
        stationName = "--"
        stationTimeViewModel.resetUI()
        stationTimeViewModel2.resetUI()
    }
    
    func updateUI(with num: String, _ name: String, _ terminal1: String, _ terminal2: String, _ arriveTime1: String, _ arriveTime2: String, and serviceStatus1: ServiceStatus, _ serviceStatus2: ServiceStatus) {
        stationNum = num
        stationName = name
        stationTimeViewModel.updateUI(with: terminal1, arriveTime: arriveTime1, serviceStatus: serviceStatus1)
        stationTimeViewModel2.updateUI(with: terminal2, arriveTime: arriveTime2, serviceStatus: serviceStatus2)
    }
}

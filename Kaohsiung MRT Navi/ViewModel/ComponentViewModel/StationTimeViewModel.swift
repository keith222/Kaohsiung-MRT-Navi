//
//  StationTimeViewModel.swift
//  Kaohsiung MRT Navi
//
//  Created by Yang Tun-Kai on 2023/1/11.
//

import Foundation

@MainActor class StationTimeViewModel: ObservableObject {
    
    @Published private(set) var terminal: String = "--"
    @Published private(set) var time: String = "--"
    @Published private(set) var serviceStatus: ServiceStatus = .notInService
    @Published var isJPorKR: Bool = false
    @Published var isShowDescription: Bool = false
    @Published var description: String = ""
    
    init() {
        if let code = Locale.autoupdatingCurrent.language.languageCode {
            isJPorKR =  (code == .japanese || code == .korean)
        }
    }
    
    func resetUI() {
        terminal = "--"
        time = "--"
        serviceStatus = .notInService
        description = ""
    }
    
    func updateUI(with terminal: String, arriveTime: String, serviceStatus: ServiceStatus) {
        self.terminal = terminal
        self.time = arriveTime
        self.serviceStatus = serviceStatus
        self.description = (time == "0" && serviceStatus == .inService) ? StringConstant.arriving : serviceStatus.description
        self.isShowDescription = (serviceStatus != .inService) || (time == "0" && serviceStatus == .inService)
    }
}

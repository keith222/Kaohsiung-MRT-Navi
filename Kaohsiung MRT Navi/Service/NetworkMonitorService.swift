//
//  NetworkService.swift
//  Kaohsiung MRT Navi
//
//  Created by Yang Tun-Kai on 2023/1/11.
//

import Foundation
import Network

final class NetworkMonitorService {
    
    private let monitor: NWPathMonitor
    private let queue = DispatchQueue(label: "Monitor")
    private(set) var isConnected: Bool = false
    
    static let shared = NetworkMonitorService()
    
    private init() {
        monitor = NWPathMonitor()
    }
    
    func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = (path.status == .satisfied)
        }
                
        monitor.start(queue: queue)
    }
    
    func stopMonitoring() {
        monitor.cancel()
    }
}

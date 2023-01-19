//
//  ContentView.swift
//  Kaohsiung MRT Navi
//
//  Created by Yang Tun-Kai on 2022/12/19.
//

import SwiftUI

struct ContentView: View {
    
    init() {
        NetworkMonitorService.shared.startMonitoring()
    }
    
    var body: some View {
        TabBarView()            
    }
}

#if !TESTING
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif

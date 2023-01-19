//
//  TabBarView.swift
//  Kaohsiung MRT Navi
//
//  Created by Yang Tun-Kai on 2022/12/24.
//

import SwiftUI

struct TabBarView: View {
    
    @State private var selection: Int = 0
 
    var body: some View {
        TabView(selection: $selection) {
            Text("Home").tabItem {
                Image(systemName: ImageConstant.house)
            }
            
            Text("Search").tabItem {
                Image(systemName: ImageConstant.magnifyingglass)
            }
            
            RouteListView().tabItem {
                Image(systemName: ImageConstant.list)
            }
            
            Text("Status").tabItem {
                Image(systemName: ImageConstant.tram)
            }
            
            Text("Settings").tabItem {
                Image(systemName: ImageConstant.setting)
            }
        }
        .accentColor(Color(.label))
    }
}

#if !TESTING
struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
#endif

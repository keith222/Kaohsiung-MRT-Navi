//
//  TabBarView.swift
//  Kaohsiung MRT Navi
//
//  Created by Yang Tun-Kai on 2022/12/24.
//

import SwiftUI

struct TabBarView: View {
    
    @State private var selection: Int = 0
    
    init() {
        setTabBarAppearance()
    }
    
    var body: some View {
        TabView(selection: $selection) {
            Text("Home").tabItem {
                Image(systemName: "house.fill")
            }
            Text("Search").tabItem {
                Image(systemName: "magnifyingglass")
            }
            RouteListView().tabItem {
                Image(systemName: "list.dash")
            }
            Text("Status").tabItem {
                Image(systemName: "tram.fill")
            }
            Text("Settings").tabItem {
                Image(systemName: "slider.horizontal.3")
            }
        }.accentColor(Color(.label))
        
    }
    
    private func setTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = .systemBackground
        UITabBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().tintColor = .secondaryLabel
    }
}

#if !TESTING
struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
#endif

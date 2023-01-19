//
//  RouteView.swift
//  Kaohsiung MRT Navi
//
//  Created by Yang Tun-Kai on 2022/12/29.
//

import SwiftUI

struct RouteListView: View {
    
    @StateObject private var viewModel: RouteListViewModel = RouteListViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                if viewModel.selection == 0 {
                    VStack(spacing: 0) {
                        ForEach(viewModel.routeCellViewModels, id: \.self) { cellViewModel in
                            NavigationLink(destination: StationListView()
                                .environmentObject(viewModel.createStationListViewModel(with: cellViewModel.routeKey))) {
                                    RouteCell(with: cellViewModel)
                                        .padding(.vertical, 15)
                                }
                        }
                        .padding(.horizontal, 30)
                        
                        Spacer()
                    }
                    .padding(.top, 99)
                    .frame(maxHeight: .infinity)
                    
                } else {
                    RouteMapView()
                }
                
                Picker(StringConstant.segmentDescription,  selection: $viewModel.selection) {
                    Image(systemName: ImageConstant.list)
                        .tag(0)
                    Image(systemName: ImageConstant.map)
                        .tag(1)
                }
                .pickerStyle(.segmented)
                .background(Color(.systemGray6))
                .padding(.top, 35)
                .padding(.horizontal, 30)
                
            }
            .background(Color(.systemGray6))
            .navigationBarTitle(viewModel.title, displayMode: .inline)
            .toolbarBackground(Color.backgroundColor, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(Color.backgroundColor, for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
        }
    }
}

#if !TESTING
struct RouteListView_Previews: PreviewProvider {
    static var previews: some View {
        RouteListView()
    }
}
#endif

//
//  StationListView.swift
//  Kaohsiung MRT Navi
//
//  Created by Yang Tun-Kai on 2022/12/30.
//

import SwiftUI

struct StationListView: View {
    
    @EnvironmentObject private var viewModel: StationListViewModel
    
    var body: some View {
        List {
            ForEach(Array(viewModel.stationCellViewModels.enumerated()), id: \.offset) { (index, cellViewModel) in
                ZStack {
                    NavigationLink(destination: NavigationLazyView( StationDetailView().environmentObject(viewModel.createStationDetailData(with: index)))
                    ) { EmptyView() }
                        .buttonStyle(.plain)
                        .opacity(0.0)
                    StationCell(with: cellViewModel)
                }
            }
            .listRowInsets(EdgeInsets())
            .listRowSeparator(.hidden)
        }
        .padding(0)
        .listStyle(.plain)
        .navigationBarTitle(viewModel.title, displayMode: .inline)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarBackground(Color.backgroundColor, for: .navigationBar)
        .toolbarBackground(.visible, for: .tabBar)        
        .background(Color.backgroundColor)
        .searchable(text: $viewModel.searchText , placement: .navigationBarDrawer(displayMode: .always), prompt: StringConstant.searchStation)
        .onChange(of: viewModel.searchText, perform: { newSearchText in
            viewModel.searchStation(with: newSearchText)
        })
    }
}

#if !TESTING
struct StationListView_Previews: PreviewProvider {
    static var previews: some View {
        StationListView()
            .environmentObject(StationListViewModel(with: .circle))
    }
}
#endif

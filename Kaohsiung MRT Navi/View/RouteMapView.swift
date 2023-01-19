//
//  RouteMapView.swift
//  Kaohsiung MRT Navi
//
//  Created by Yang Tun-Kai on 2023/1/10.
//

import SwiftUI
import MapKit

struct RouteMapView: View {
    
    @StateObject private var viewModel: RouteMapViewModel = RouteMapViewModel()
    
    var body: some View {
        ZStack(alignment: .center) {
            MapView(viewModel: viewModel.createMapViewModel(), selectedAnnotation: $viewModel.selectedAnnotation)
            
            VStack(spacing: 150) {
                TrainInfoView()
                    .padding(.horizontal, 20)
                    .environmentObject(viewModel.trainInfoViewModel)

                if viewModel.isIntersaction {
                    TrainInfoView()
                        .padding(.horizontal, 20)
                        .environmentObject(viewModel.trainInfoViewModel2)
                    
                } else {
                    Spacer()
                }
            }
            .frame(height: 430)
            .offset(y: viewModel.offsetY)
            .animation(.spring(dampingFraction: 0.8), value: viewModel.offsetY)
            .zIndex(1)
        }
        .alert(StringConstant.alert, isPresented: $viewModel.showError.result, actions: {
            Button("OK", action: {})
        }, message: {
            Text(viewModel.showError.message)
        })
    }
}


//#if !TESTING
//struct RouteMapView_Previews: PreviewProvider {
//    static var previews: some View {
//        RouteMapView()
//    }
//}
//#endif

//
//  StationMapView.swift
//  Kaohsiung MRT Navi
//
//  Created by Yang Tun-Kai on 2023/1/7.
//

import SwiftUI
import MapKit

struct StationMapView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject private var viewModel: StationMapViewModel
    
    var body: some View {
        ZStack(alignment: .top) {
            Map(coordinateRegion: $viewModel.region,
                annotationItems: viewModel.places
            ) { place in
                MapAnnotation(coordinate: place.coordinate) {
                        PlaceAnnotationView(with: viewModel.createPlaceAnnotationViewModel(of: place))
                }
            }
            .ignoresSafeArea()
            
            HStack {
                Spacer()
                
                Button(action: {
                    dismiss()
                }, label: {
                    Image(systemName: ImageConstant.xMark)
                        .resizable()
                        .scaledToFill()
                        .foregroundColor(Color(.label))
                })
                .padding(8)
                .frame(width: 30, height: 30)
                .background(Color.backgroundColor)
                .clipShape(Circle())
                .shadow(radius: 7)
            }
            .padding(.top, 25)
            .padding(.trailing, 25)
            .frame(maxWidth: .infinity)
        }
    }
}

struct StationMapView_Previews: PreviewProvider {
    static var previews: some View {
        let station = RouteService.shared.routes!.red[2]
        StationMapView()
            .environmentObject(StationMapViewModel(stationNum: station.num, geoHash: station.geoHash, exitGeoHash: station.exit!))
    }
}

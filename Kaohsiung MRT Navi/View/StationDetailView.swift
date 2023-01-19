//
//  StationDetailView.swift
//  Kaohsiung MRT Navi
//
//  Created by Yang Tun-Kai on 2023/1/4.
//

import SwiftUI
import Zoomable
import Kingfisher

struct StationDetailView: View {
    
    private let itemLayout: [GridItem] = [GridItem(.flexible())]
    
    @EnvironmentObject private var viewModel: StationDetailViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                Image(viewModel.stationImageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 148, height: 148)
                    .padding(.top, 20)
                
                Text(viewModel.stationName)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(.label))
                    .font(.system(size: 28, weight: .semibold))
                    .padding(.top, 15)
                    .padding(.horizontal, 35)
                    .frame(maxWidth: .infinity)
                
                Text(viewModel.stationSubName)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(.secondaryLabel))
                    .font(.system(size: 20, weight: .semibold))
                    .padding(.top, 5)
                
                HStack(alignment: .center, spacing: 10) {
                    ForEach(viewModel.tagViewModels, id: \.self) { tagViewModel in
                        TagView(with: tagViewModel)
                    }
                }
                .padding(.top, 15)
                
                if !viewModel.exitInfoViewModels.isEmpty {
                    Text(StringConstant.exitInfo)
                        .font(.system(.title2, weight: .semibold))
                        .padding(.top, 30)
                        .padding(.bottom, 10)
                        .padding(.leading, 20)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    ForEach(viewModel.exitInfoViewModels, id: \.self) { infoViewModel in
                        ExitInfoView(with: infoViewModel)
                    }
                    .padding(.top, 15)
                    .padding(.leading, 35)
                    .padding(.trailing, 30)
                }
                
                if !viewModel.checkIsCircleLine() {
                    Text(StringConstant.stationPlan)
                        .font(.system(.title2, weight: .semibold))
                        .padding(.top, 30)
                        .padding(.bottom, 25)
                        .padding(.leading, 20)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    HStack {
                        ZoomableView(size: CGSize(width: screenWidth, height: 400), min: 1.0, max: 6.0, showsIndicators: false) {
                            KFImage(viewModel.getStationPlanURL())
                                .fade(duration: 0.25)
                                .resizable()
                                .scaledToFit()
                        }
                    }
                    .frame(maxHeight: 400)
                }
                
                HStack {
                    Button(action: {
                        viewModel.showSheet.toggle()
                    }, label: {
                        Image(systemName: ImageConstant.mapFill)
                            .resizable()
                            .scaledToFill()
                            .foregroundColor(Color(.label))
                    })
                    .sheet(isPresented: $viewModel.showSheet) {
                        StationMapView()
                            .environmentObject(viewModel.createMapViewModel())
                            .presentationDetents([.medium, .large])
                    }
                    .padding(12)
                    .frame(width: 55, height: 55)
                    .background(Color.backgroundColor)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .strokeBorder(Color.circleBorderColor, lineWidth: 1)
                    )
                    .shadow(radius: 7)
                }
                .padding(.top, 40)
                .padding(.bottom, 40)
            }
            .frame(maxWidth: .infinity)
        }
        .navigationBarTitle(viewModel.stationName, displayMode: .inline)
        .toolbarBackground(Color.backgroundColor, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .background(Color.backgroundColor)
    }
}


#if !TESTING
struct StationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let station = RouteService.shared.routes!.red[4]
        StationDetailView()
            .environmentObject(StationDetailViewModel(with: station))
    }
}
#endif

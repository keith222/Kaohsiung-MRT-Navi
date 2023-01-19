//
//  TrainInfoView.swift
//  Kaohsiung MRT Navi
//
//  Created by Yang Tun-Kai on 2023/1/11.
//

import SwiftUI

struct TrainInfoView: View {
    
    @EnvironmentObject private var viewModel: TrainInfoViewModel
    
    var body: some View {
        VStack(alignment: .center, spacing: 5) {
            HStack(spacing: 5) {
                Text(viewModel.stationName)
                    .font(.system(size: 20))
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                if !viewModel.imageName.isEmpty {
                    Image(viewModel.imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 45, height: 45)
                }
            }
            
            Divider()
                .frame(height: 2)
                .overlay(Color(.systemGray6))
            
            HStack(alignment: .top, spacing: 0) {
                StationTimeView()
                    .environmentObject(viewModel.stationTimeViewModel)
                
                Divider()
                    .frame(width: 2)
                    .overlay(Color(.systemGray6))
                    .padding(.horizontal, 15)
                
                StationTimeView()
                    .environmentObject(viewModel.stationTimeViewModel2)
            }
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 5)
        .foregroundColor(Color(.label))
        .frame(height: 140)
        .background(Color.backgroundColor)
        .cornerRadius(5)
        .clipped()
        .shadow(color: .black.opacity(0.3), radius: 10)
    }
}

#if !TESTING
struct TrainInfoView_Previews: PreviewProvider {
    static var previews: some View {
        TrainInfoView()
            .environmentObject(TrainInfoViewModel())
    }
}
#endif

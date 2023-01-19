//
//  StationCell.swift
//  Kaohsiung MRT Navi
//
//  Created by Yang Tun-Kai on 2022/12/30.
//

import SwiftUI

struct StationCell: View {
    
    private let viewModel: StationCellViewModel
    
    init(with viewModel: StationCellViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            ZStack {
                Image(viewModel.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 55, height: 55)
                    .background(.clear)
                
                VerticalLineView(with: viewModel.createVerticalLineViewModel())
                
                HorizontalLineView(with: viewModel.createHorizontalLineViewModel())
            }
            .frame(maxHeight: .infinity)
            
            VStack(alignment: .leading, spacing: 0) {
                Text(viewModel.stationName)
                    .foregroundColor(Color(.label))
                    .font(.system(size: 20, weight: .semibold ))
                    .multilineTextAlignment(.leading)
                
                Text(viewModel.stationSubName)
                    .foregroundColor(Color(.secondaryLabel))
                    .font(.system(size: 12, weight: .semibold ))
                    .multilineTextAlignment(.leading)
                    .padding(.top, 3)
                
                Divider()
                    .background(Color.subtitleColor)
                    .padding(.top, 15)
            }
            .frame(maxHeight: .infinity)
            .padding(.leading, 10)
            .padding(.top, 15)
        }
        .fixedSize(horizontal: false, vertical: true)
        .padding(.trailing, 15)
        .background(Color.backgroundColor)
    }
}

#if !TESTING
struct StationCell_Previews: PreviewProvider {
    static var previews: some View {
        StationCell(with: StationCellViewModel(stationNum: "c1", stationName: "Kaohsiung International Airport", stationSubName: "TEST"))
    }
}
#endif

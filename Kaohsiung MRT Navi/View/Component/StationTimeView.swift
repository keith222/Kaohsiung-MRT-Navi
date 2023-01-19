//
//  StationTimeView.swift
//  Kaohsiung MRT Navi
//
//  Created by Yang Tun-Kai on 2023/1/11.
//

import SwiftUI

struct StationTimeView: View {
    
    @EnvironmentObject private var viewModel: StationTimeViewModel
        
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .firstTextBaseline) {
                if !viewModel.isJPorKR {
                    Text(StringConstant.to)
                        .font(.system(size: 12))
                }
                
                Text(viewModel.terminal)
                    .font(.system(size: 18, weight: .semibold))
                
                if viewModel.isJPorKR {
                    Text(StringConstant.to)
                }
            }
            
            Spacer()
            
            HStack(alignment: .lastTextBaseline) {
                Spacer()
                
                if !viewModel.isShowDescription {
                    Text(viewModel.time)
                        .font(.system(size: 30, weight: .thin))
                    
                    Text(StringConstant.min)
                        .font(.system(size: 12))
                    
                } else {
                    Text(viewModel.description)
                        .minimumScaleFactor(0.5)
                        .lineLimit(1)
                        .font(.system(size: 16))
                        .padding(.bottom, 5)
                }
            }
        }
    }
}

struct StationTimeView_Previews: PreviewProvider {
    static var previews: some View {
        StationTimeView()
    }
}

//
//  ExitInfoView.swift
//  Kaohsiung MRT Navi
//
//  Created by Yang Tun-Kai on 2023/1/6.
//

import SwiftUI

struct ExitInfoView: View {
    
    private let viewModel: ExitInfoViewModel
    private let itemLayout: [GridItem] = Array(repeating: GridItem(.flexible()), count: 2)
    
    init(with viewModel: ExitInfoViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            HStack(alignment: .bottom, spacing: 15) {
                Text("\(StringConstant.exit)\(viewModel.exitNum)")
                    .foregroundColor(Color(.label))
                    .font(.system(.title3, weight: .semibold))
                
                VStack(alignment: .leading, spacing: 10) {
                    if viewModel.escalator.count > 0 || viewModel.categories.count > 0 || viewModel.hasElevator || viewModel.hasToilet {
                        HStack {
                            ForEach(viewModel.escalator, id: \.self) { escalator in
                                Image(escalator.rawValue)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 26, height: 26)
                                    .foregroundColor(Color(.label))
                                    .padding(2)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(Color(.label), lineWidth: 0.5)
                                    )
                            }
                            
                            if viewModel.hasElevator {
                                Image(ImageConstant.elevalator)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 26, height: 26)
                                    .foregroundColor(Color(.label))
                                    .padding(2)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(Color(.label), lineWidth: 0.5)
                                    )
                            }
                            
                            if viewModel.hasToilet {
                                Image(ImageConstant.toilet)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(Color(.label))
                                    .padding(3)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(Color(.label), lineWidth: 0.5)
                                    )
                            }
                            
                            ForEach(viewModel.categories, id: \.self) { category in
                                if category == .lrt {
                                    Image(ImageConstant.circleLine)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 30, height: 30)
                                    
                                } else {
                                    Text(category.icon)
                                        .foregroundColor(Color(.label))
                                        .font(.custom("Taiwanicon-20",size: 25))
                                        .clipped()
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 5)
                                                .stroke(Color(.label), lineWidth: 0.5)
                                        )
                                }
                            }
                        }
                    }
                    
                    Text(viewModel.info)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(Color(.label))
                        .font(.system(.title3))
                }
            }
            
            Divider()
                .padding(.top, 7)
        }
    }
}

#if !TESTING
struct ExitInfoView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ExitInfoViewModel(exitNum: 1, info: "Exit", categories: [.youbike, .tra, .thsr, .lrt], hasElevator: true, hasToilet: true, escalator: [.up, .down])
        ExitInfoView(with: viewModel)
    }
}
#endif

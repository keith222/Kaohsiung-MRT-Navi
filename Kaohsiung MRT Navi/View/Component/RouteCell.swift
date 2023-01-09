//
//  RouteListCell.swift
//  Kaohsiung MRT Navi
//
//  Created by Yang Tun-Kai on 2022/12/29.
//

import SwiftUI

struct RouteCell: View {
    
    private let viewModel: RouteCellViewModel
    
    init(with viewModel: RouteCellViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack(spacing: 0) {
            Image(viewModel.routeImageName)
                .resizable()
                .scaledToFill()
                .frame(width: 32, height: 32)
            VStack(alignment: .leading) {
                Text(viewModel.routeName)
                    .foregroundColor(Color(.label))
                    .font(.system(size: 18, weight: .semibold ))
                Text("\(viewModel.routeStartStation) - \(viewModel.routeTerminalStation)")
                    .foregroundColor(.subtitleColor)
                    .font(.system(size: 12, weight: .semibold ))
            }
            .padding(.leading, 24)
            Spacer()
            Image(systemName: ImageConstant.chevronRight)
                .frame(width: 10)
                .foregroundColor(.arrowColor)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 13)
        .padding(.leading, 20)
        .padding(.trailing, 10)
        .background(Color.cellColor)
        .cornerRadius(5)
    }
}

#if !TESTING
struct RouteListCell_Previews: PreviewProvider {
    static var previews: some View {
        RouteCell(with: RouteCellViewModel(routeName: "Red", routeStartStation: "GangShan South", routeTerminalStation: "Siaogang", routeImageName: "RedLine", routeKey: .red))
    }
}
#endif

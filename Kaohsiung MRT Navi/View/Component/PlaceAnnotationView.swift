//
//  PlaceAnnotationView.swift
//  Kaohsiung MRT Navi
//
//  Created by Yang Tun-Kai on 2023/1/8.
//

import SwiftUI

struct PlaceAnnotationView: View {
    
    private let viewModel: PlaceAnnotationViewModel
    
    init(with viewModel: PlaceAnnotationViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(spacing: 0) {
            if viewModel.exit < 1 {
                Image(viewModel.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40)
                    .background(Color.backgroundColor)
                    .clipShape(Circle())
                
            } else {
                Text(viewModel.exitText)
                    .font(.footnote)
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                    .padding(10)
                    .background(viewModel.color)
                    .clipShape(Circle())
            }
            
            Image(systemName: ImageConstant.arrowDown)
                .font(.caption)
                .foregroundColor(viewModel.color)
                .offset(x: 0, y: -2.7)
        }
    }
}

#if !TESTING
struct PlaceAnnotationView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            PlaceAnnotationView(with: PlaceAnnotationViewModel(stationNum: "r5", exit: 0))
            PlaceAnnotationView(with: PlaceAnnotationViewModel(stationNum: "r5", exit: 1))
        }
        
    }
}
#endif

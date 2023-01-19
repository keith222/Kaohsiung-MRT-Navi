//
//  VerticalLineView.swift
//  Kaohsiung MRT Navi
//
//  Created by Yang Tun-Kai on 2023/1/8.
//

import SwiftUI

struct VerticalLineView: View {
    
    private let viewModel: LineViewModel
    
    init(with viewModel: LineViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(spacing: 0) {
            if viewModel.isStart && viewModel.isCircle {
                DottedLine()
                    .stroke(style: StrokeStyle(lineWidth: 7, dash: [2]))
                    .frame(maxWidth: 1, maxHeight: .infinity)
                    .foregroundColor(.circleLineColor)
                
            } else {
                Rectangle()
                    .fill(viewModel.isStart && !viewModel.isCircle ? .clear : viewModel.color)
                    .frame(maxWidth: 7, maxHeight: .infinity)
            }
            
            Rectangle()
                .fill(.clear)
                .frame(width: 55, height: 41)
            
            if viewModel.isTerminal && viewModel.isCircle {
                DottedLine()
                    .stroke(style: StrokeStyle(lineWidth: 7, dash: [2]))
                    .frame(maxWidth: 1, maxHeight: .infinity)
                    .foregroundColor(.circleLineColor)
                
            } else {
                Rectangle()
                    .fill(viewModel.isTerminal && !viewModel.isCircle ? .clear : viewModel.color)
                    .frame(maxWidth: 7, maxHeight: .infinity)
            }
        }
    }
}

#if !TESTING
struct VerticalLineView_Previews: PreviewProvider {
    static var previews: some View {
        VerticalLineView(with: LineViewModel(color: .circleLineColor, isStart: true, isTerminal: true, isCircle: true))
    }
}
#endif

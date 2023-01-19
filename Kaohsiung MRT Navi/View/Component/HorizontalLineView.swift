//
//  HorizontalLineView.swift
//  Kaohsiung MRT Navi
//
//  Created by Yang Tun-Kai on 2023/1/8.
//

import SwiftUI

struct HorizontalLineView: View {
    
    private let viewModel: LineViewModel
    
    init(with viewModel: LineViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack(spacing: 0) {
            Rectangle()
                .fill(viewModel.color)
                .frame(width: 16, height: 7)
            
            Rectangle()
                .fill(.clear)
                .frame(width: 53, height: 55)
            
            Rectangle()
                .fill(viewModel.color)
                .clipShape(Capsule())
                .frame(width: 16, height: 7)
                .offset(x: -4)
        }
    }
}

#if !TESTING
struct HorizontalLineView_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalLineView(with: LineViewModel(color: .orangeLineColor, isStart: true, isTerminal: true))
    }
}
#endif

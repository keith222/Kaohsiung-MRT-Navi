//
//  TagView.swift
//  Kaohsiung MRT Navi
//
//  Created by Yang Tun-Kai on 2023/1/5.
//

import SwiftUI

struct TagView: View {
    
    private let viewModel: TagViewModel
    
    init(with viewModel: TagViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack(spacing: 3) {
            Text(viewModel.category.title)
                .foregroundColor(.white)
                .font(.system(size: 14, weight: .semibold))
            
            switch viewModel.category {
            case .airport:
                Text(Image(systemName: viewModel.category.icon))
                    .foregroundColor(.white)
                    .font(.system(size: 14, weight: .semibold))
                
            case .redLine, .orangeLine, .lrt:
                Text(viewModel.category.icon)
                    .foregroundColor(.white)
                    .font(.system(size: 14, weight: .semibold))
                
            default:
                Text(viewModel.category.icon)
                    .foregroundColor(.white)
                    .font(.custom("Taiwanicon-20",size: 19))
                    .padding(.bottom, 2)
            }
            
        }
        .frame(height: 25)
        .padding(.horizontal, 10)
        .background(viewModel.category.backgroundColor.cornerRadius(12.5))
    }
}

#if !TESTING
struct TagView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            TagView(with: TagViewModel(category: .thsr))
            TagView(with: TagViewModel(category: .tra))
            TagView(with: TagViewModel(category: .airport))
            TagView(with: TagViewModel(category: .youbike))
            TagView(with: TagViewModel(category: .redLine))
            TagView(with: TagViewModel(category: .orangeLine))
            TagView(with: TagViewModel(category: .lrt))
        }
    }
}
#endif

//
//  NavigationLazyView.swift
//  Kaohsiung MRT Navi
//
//  Created by Yang Tun-Kai on 2023/1/6.
//

import SwiftUI

struct NavigationLazyView<Content: View>: View {
    let build: () -> Content
    
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    
    var body: Content {
        build()
    }
}


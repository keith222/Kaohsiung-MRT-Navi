//
//  ViewExtension.swift
//  Kaohsiung MRT Navi
//
//  Created by Yang Tun-Kai on 2023/1/7.
//

import Foundation
import UIKit
import SwiftUI

extension View {
    
    var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
}

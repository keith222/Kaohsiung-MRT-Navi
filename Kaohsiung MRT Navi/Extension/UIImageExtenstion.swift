//
//  UIImageExtenstion.swift
//  Kaohsiung MRT Navi
//
//  Created by Yang Tun-Kai on 2023/1/10.
//

import Foundation
import UIKit

extension UIImage {
    
    func imageWithColor(backgroundColor: UIColor)->UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        
        backgroundColor.setFill()
        let rect = CGRect(origin: .zero, size: self.size)
        let path = UIBezierPath(arcCenter: CGPoint(x: rect.midX, y: rect.midY), radius: rect.midX, startAngle: 0, endAngle: 6.28319, clockwise: true)
        path.fill()
        self.draw(at: .zero)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}


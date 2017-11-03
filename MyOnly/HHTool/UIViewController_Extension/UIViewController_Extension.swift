//
//  UIViewController_Extension.swift
//  MyOnly
//
//  Created by mac on 2017/11/3.
//  Copyright © 2017年 macZh. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    class func colorWithHex(_ hex: String, alpha: CGFloat = 1.0) -> UIColor {
        var rgb: CUnsignedInt = 0;
        let scanner = Scanner(string: hex)
        
        if hex.hasPrefix("#") {
            scanner.scanLocation = 1
        }
        scanner.scanHexInt32(&rgb)
        
        let r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((rgb & 0xFF00) >> 8) / 255.0
        let b = CGFloat(rgb & 0xFF) / 255.0
        
        return UIColor(red: r, green: g, blue: b, alpha: alpha)
    }
    
}

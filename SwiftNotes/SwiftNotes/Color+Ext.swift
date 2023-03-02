//
//  Color+Ext.swift
//  SwiftNotes
//
//  Created by DOVE on 2023/3/1.
//  Copyright © 2023 Hegk. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    /// 十六进制颜色转换为UIColor对象
    /// - Parameter hexString: 十六进制颜色
    convenience init?(hexString: String) {
        
        let r, g, b, a: CGFloat
        
        guard hexString.hasPrefix("#") else {
            return nil
        }
        
        let start    = hexString.index(hexString.startIndex, offsetBy: 1)
        let hexColor = String(hexString[start...])
        guard hexColor.count == 6 else {
            return nil
        }
        
        let scanner = Scanner(string: hexColor)
        var hexNumber: UInt64 = 0
        guard scanner.scanHexInt64(&hexNumber) else {
            return nil
        }
        
        r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
        g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
        b = CGFloat(hexNumber & 0x0000ff) / 255
        a = 1

        self.init(red: r, green: g, blue: b, alpha: a)
    }
}


//
//  LCEColorHex.swift
//  LCEBarnSwallow
//
//  Created by 妖狐小子 on 2018/5/17.
//  Copyright © 2018年 yaohuxiaozi. All rights reserved.
//

import UIKit

public let lceBgColor = UIColor.colorWithHex(0xf2f2f2)
public let lceLineColor = UIColor.colorWithHex(0xC9CACF)

extension UIColor {
    
    open class func colorWithHex(_ hexValue: Int) -> UIColor {
        return colorWithAlphaHex(hexValue, alpha: 1.0)
    }
    
    open class func colorWithAlphaHex(_ hexValue: Int, alpha: CGFloat) -> UIColor {
        let red = (hexValue & 0xFF0000) >> 16
        let green = (hexValue & 0xFF00) >> 8
        let blue = (hexValue & 0xFF)
        return UIColor(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: alpha)
    }
    
}

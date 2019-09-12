//
//  UIColor+Extension.swift
//  Local Tackle Shop
//
//  Created by Abhijit Rana on 27/04/18.
//  Copyright © 2018 Sourav Mishra. All rights reserved.
//

import Foundation
import UIKit

extension UIColor{
 
    func colorFromHexString (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    
    var dividerColor: UIColor {
            return UIColor().colorFromHexString(hex: "1A1A1A")
    }
    
    var startGradientBgColor: UIColor {
        return UIColor().colorFromHexString(hex: "333333")
    }
    
    var midGradientBgColor: UIColor {
        return UIColor().colorFromHexString(hex: "1A1A1A")
    }
    
    var endGradientBgColor: UIColor {
        return UIColor().colorFromHexString(hex: "000000")
    }
    
}


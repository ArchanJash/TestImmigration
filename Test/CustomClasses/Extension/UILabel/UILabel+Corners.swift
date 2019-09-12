//
//  UILabel+Corners.swift
//  Local Tackle Shop
//
//  Created by Umesh kumar on 04/05/18.
//  Copyright © 2018 Umesh Verma. All rights reserved.
//

import UIKit

extension UILabel {
    func roundedCorner(){
        let maskPAth1 = UIBezierPath(roundedRect: self.bounds,
                                     byRoundingCorners: [.bottomLeft],
                                     cornerRadii:CGSize(width: 5, height: 5))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = self.bounds
        maskLayer1.path = maskPAth1.cgPath
        self.layer.mask = maskLayer1
    }
    
    func setCharacterSpacing(charSpacing : CGFloat, lineSpace : CGFloat) {
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpace
        paragraphStyle.lineHeightMultiple = 0
        
        
        let attributedString = NSMutableAttributedString(string: self.text!)
//        let charecterSpaceAttr :  = (NSAttributedStringKey.kern, value: charSpacing, range: NSRange(location: 0, length: attributedString.length))
//        let lineSpaceAttr = (NSAttributedStringKey.paragraphStyle, value:paragraphStyle, range:NSRange(location: 0, length: attributedString.length))
        
 
        attributedString.addAttribute(NSAttributedString.Key.kern, value: charSpacing, range: NSRange(location: 0, length: attributedString.length))
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSRange(location: 0, length: attributedString.length))
        
        self.attributedText = attributedString
 
    }
}

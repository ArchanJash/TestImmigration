//
//  UIView+Extension.swift
//  Clever Queue User
//
//  Created by Abhijit   on 24/07/17.
//  Copyright © 2017 Clever Queue. All rights reserved.
//

import UIKit
@IBDesignable
extension UIView {
    
    @IBInspectable
    var cornerRadiusExt: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius)
            layer.shadowPath = shadowPath.cgPath
            layer.masksToBounds = false
//            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable
    var borderWidthExt: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColorExt: UIColor? {
        get {
            let color = UIColor(cgColor: layer.borderColor!)
            return color
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable
    var shadowRadiusExt: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowOffset = CGSize.zero
            layer.shadowRadius = shadowRadiusExt
        }
    }
    
    @IBInspectable
    var shadowOpacityExt:Float {
        get{
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowColorExt:UIColor? {
        get{
            let color = UIColor(cgColor: layer.shadowColor!)
            return color
        }
        set {
            layer.shadowColor = newValue?.cgColor
        }
    }
    
    @IBInspectable
    var setBackgroundImage:UIImage? {
        get{
            return UIImage()
        }
        set {
            let imageView = UIImageView(frame: UIScreen.main.bounds)
            imageView.image = newValue
            imageView.contentMode = .scaleToFill
            self.addSubview(imageView)
            sendSubviewToBack(imageView)
        }
    }
    
 
    func applyGradient() {
        let gradient = CAGradientLayer()
        
        let startColor = UIColor().startGradientBgColor.cgColor
        let midColor = UIColor().midGradientBgColor.cgColor
        let endColor = UIColor().endGradientBgColor.cgColor
        
        
        gradient.colors = [startColor,midColor,endColor]
        gradient.locations = [0.0, 0.5, 1.0]
        gradient.frame = UIScreen.main.bounds
        self.layer.insertSublayer(gradient, at: 0)
    }
 
    func applyBlurryGradient() {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [
            UIColor(white: 1, alpha: 0).cgColor,
            UIColor(white: 1, alpha: 0.3).cgColor,
            UIColor(white: 1, alpha: 1).cgColor,
            UIColor(white: 1, alpha: 1).cgColor
        ]
        gradient.locations = [0, 0.2, 1, 1]
        self.layer.mask = gradient
//        self.layer.insertSublayer(gradient, at: 0)
    }
 
    func roundedSideCorner(){
        let maskPAth1 = UIBezierPath(roundedRect: self.bounds,
                                     byRoundingCorners: [.bottomLeft],
                                     cornerRadii:CGSize(width: 5, height: 5))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = self.bounds
        maskLayer1.path = maskPAth1.cgPath
        self.layer.mask = maskLayer1
    }
}
extension UIView{
    var nibName: String {
        return String(describing: type(of: self))
    }
}

@IBDesignable
extension UIButton {
    @IBInspectable var isUpperCaseText:Bool {
        get { return false }
        set(key) {
            if key {
                setTitle(self.titleLabel?.text?.uppercased(), for: .normal)
                
            }else {
                setTitle(self.titleLabel?.text, for: .normal)
            }
        }
    }
}







 

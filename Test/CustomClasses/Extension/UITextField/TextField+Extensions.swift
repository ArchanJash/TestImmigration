//
//  TextField+Extensions.swift
//  Local Tackle Shop
//
//  Created by Abhijit Rana on 19/04/18.
//  Copyright © 2018 Sourav Mishra. All rights reserved.
//

import Foundation
import UIKit


extension UITextField{
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
}

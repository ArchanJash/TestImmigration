//
//  UIImageView+Color.swift
//  Local Tackle Shop
//
//  Created by Umesh kumar on 07/05/18.
//  Copyright © 2018 Umesh Verma. All rights reserved.
//

import UIKit

extension UIImageView {
    func setImageColor(color: UIColor) {
        let templateImage = self.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
}

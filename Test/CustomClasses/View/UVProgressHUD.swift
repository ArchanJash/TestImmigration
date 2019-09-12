//
//  UVAlertView.swift
//  Local Tackle Shop
//
//  Created by Umesh kumar on 28/05/18.
//  Copyright © 2018 Umesh Verma. All rights reserved.
//

import UIKit

class UVProgressHUD: NSObject {
    let blackView = UIView()
    
    let progressView:UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 5.0
        view.layer.masksToBounds = true
        return view
    }()
    
    let progressImageView:UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .clear
        return view
    }()
    
    fileprivate struct Constants {
        static let sharedHUD = UVProgressHUD()
        static let width = 80
        static let height = 80
    }
    
    class var sharedHUD: UVProgressHUD {
        return Constants.sharedHUD
    }
    
    override init() {
        super.init()
    }
    
    var viewVisible:Bool = false {
        didSet {
            if viewVisible {
                self.setViewVisibility(1)
            }else {
                self.setViewVisibility(0)
            }
        }
    }
    
    var isAlreadyVisible = false
    
    func show() {
        guard !self.isAlreadyVisible else {
            return
        }
        if let window = UIApplication.shared.keyWindow {
            self.blackView.backgroundColor = .clear//UIColor(white: 0, alpha: 0.4)
            self.blackView.isUserInteractionEnabled = true
            window.addSubview(blackView)
            
            self.progressView.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: Constants.width, height: Constants.height))
            self.progressView.center = window.center
            self.progressView.addBlurEffect()
            window.addSubview(self.progressView)
            
            self.setupImageView()
            
            self.blackView.frame = window.frame
            self.viewVisible = false
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                //self.progressView.transform = CGAffineTransform(scaleX: 2, y: 2)
                self.viewVisible = true
                self.isAlreadyVisible = true
            }, completion: nil)
        }
    }
    
    private func setupImageView(){
        self.progressView.addSubview(self.progressImageView)
        self.progressImageView.translatesAutoresizingMaskIntoConstraints = false
        self.progressImageView.centerXAnchor.constraint(equalTo: self.progressView.centerXAnchor).isActive = true
        self.progressImageView.centerYAnchor.constraint(equalTo: self.progressView.centerYAnchor).isActive = true
        self.progressImageView.widthAnchor.constraint(equalToConstant: CGFloat(Constants.width - 20)).isActive = true
        self.progressImageView.heightAnchor.constraint(equalToConstant: CGFloat(Constants.height - 20)).isActive = true
        self.progressImageView.contentMode = .scaleAspectFit
        self.progressImageView.image = UIImage(named: "loading")
        rotateView(targetView: self.progressImageView, duration: 1.0)
    }
    
    private func setViewVisibility(_ value:CGFloat){
        self.blackView.alpha = value
        self.progressView.alpha = value
    }
    
    func hide() {
        UIView.animate(withDuration: 0.5, animations: {
            //self.progressView.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.viewVisible = false
            self.isAlreadyVisible = false
        })
    }
    
    private func rotateView(targetView: UIView, duration: Double ) {
        UIView.animate(withDuration: duration, delay: 0.0, options: .curveLinear, animations: {
            targetView.transform = targetView.transform.rotated(by: .pi)
        }) { finished in
            self.rotateView(targetView: targetView, duration: duration)
        }
    }
}

extension UIView {
    func addBlurEffect() {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.prominent)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        self.addSubview(blurEffectView)
    }
}

//
//  CalendarPicker.swift
//  Dealup-New-Design
//
//  Created by Temow on 10/08/17.
//  Copyright © 2017 Temow IT Solutions. All rights reserved.
//

import UIKit

protocol CalendarDateDelegate:class {
    func calendarDidFinished(_ dateText: Date,indexPath: IndexPath,postType:PostType)
    
}

class CalendarPicker:NSObject {
    private let blackView = UIView()
    private var container = UIView()
    
    weak var delegate: CalendarDateDelegate? = nil
    var index:IndexPath? = nil
    var postType:PostType = .none
    
    let picker:UIDatePicker = {
        let view = UIDatePicker()
        view.datePickerMode = .date
        view.minimumDate = Date()
        return view
    }()
    
    private let doneButton:UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Done", for: .normal)
        return button
    }()
    
    private let doneView:UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    func showView(_ index:IndexPath,postType:PostType) {
        if let window = UIApplication.shared.keyWindow {
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            blackView.isUserInteractionEnabled = true
            window.addSubview(blackView)
            
            let height:CGFloat = window.frame.height * 0.35
            
            container = UIView(frame: CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height))
            container.backgroundColor = .white
            container.layer.cornerRadius = 5
            window.addSubview(container)
            
            blackView.frame = window.frame
            blackView.alpha = 0
            self.index = index
            self.postType = postType
            let y = window.frame.height - self.container.frame.height
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 1
                self.container.frame = CGRect(x: 0, y: y, width: self.container.frame.width, height: self.container.frame.height)
            }, completion: nil)
            setupViews()
        }
    }
    
    private func setupViews(){
        container.addSubview(picker)
        container.addSubview(doneView)
        doneView.addSubview(doneButton)
        
        container.addConstraintsWithFormat(format: "H:|[v0]|", views: doneView)
        container.addConstraintsWithFormat(format: "V:|[v0(50)]", views: doneView)
        
        container.addConstraintsWithFormat(format: "H:|[v0]|", views: picker)
        container.addConstraintsWithFormat(format: "V:[v0]-8-[v1]|", views: doneView,picker)
        
        doneView.addConstraintsWithFormat(format: "H:[v0]-16-|", views: doneButton)
        doneView.addConstraintsWithFormat(format: "V:|[v0]|", views: doneButton)
        
        doneButton.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
    }
    
    @objc private func handleDismiss() {
        delegate?.calendarDidFinished(picker.date,indexPath: index!,postType:self.postType)
        UIView.animate(withDuration: 0.5, animations: {
            self.blackView.alpha = 0
            if let window = UIApplication.shared.keyWindow {
                self.container.frame = CGRect(x: 0, y: window.frame.height, width: self.container.frame.width, height: self.container.frame.height)
            }
        })
    }
}

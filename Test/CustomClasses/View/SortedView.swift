//
//  SortedView.swift
//  Local Tackle Shop
//
//  Created by Umesh kumar on 12/06/18.
//  Copyright © 2018 Umesh Verma. All rights reserved.
//

import UIKit

struct PopupItem{
    var id:String = ""
    var title:String = ""
     var price:String = ""
}
var popup = PopupItem()
protocol SortedViewDelegate:class {
    func sortedViewDidFinished(_ itemID: String,itemTitle: String, price: String, indexPath:IndexPath)
}

class SortedView: NSObject,UITableViewDataSource,UITableViewDelegate {
    
    private let blackView = UIView()
    private let cellID = "cellID"
    
    weak var delegate: SortedViewDelegate? = nil
    var index:IndexPath? = nil
    var postType:PostType = .none
    
    var menuOptionNameArray : [PopupItem]! {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    private lazy var tableView:UITableView = {
        let cv = UITableView(frame: .zero, style: .plain)
        cv.backgroundColor = .white
        cv.layer.cornerRadius = 6.0
        cv.layer.masksToBounds = true
        cv.delegate = self
        cv.dataSource = self
        cv.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
        cv.separatorStyle = .singleLine
        cv.isScrollEnabled = false
        return cv
    }()
    
    override init() {
        super.init()
    }
    
    func showView() {
        if let window = UIApplication.shared.keyWindow {
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            blackView.isUserInteractionEnabled = true
            window.addSubview(blackView)
            
            let height:CGFloat = CGFloat(menuOptionNameArray.count + 1) * CGFloat(50)
            let y = (window.frame.height/2) - (height/2)
            
            tableView.frame = CGRect(x: CGFloat(16), y: y, width: window.frame.width - 32, height: height)
            
            window.addSubview(tableView)
            
            blackView.frame = window.frame
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            blackView.alpha = 1
            
//            self.index = index
//            self.postType = postType
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 1
                self.tableView.frame = CGRect(x: 16, y: y, width: self.tableView.frame.width, height: self.tableView.frame.height)
                
            }, completion: nil)
            
        }
    }
    
    @objc private func handleDismiss() {
        UIView.animate(withDuration: 0.5, animations: {
            self.blackView.alpha = 0
            if let window = UIApplication.shared.keyWindow {
                self.tableView.frame = CGRect(x: 16, y: window.frame.height, width: self.tableView.frame.width, height: self.tableView.frame.height)
            }
        })
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuOptionNameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        cell.textLabel?.text = menuOptionNameArray[indexPath.row].title + " ml"
        
        if indexPath.row == menuOptionNameArray.count -  1 {
            tableView.separatorStyle = .none
        }else {
            tableView.separatorStyle = .singleLine
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(self.menuOptionNameArray)
        print(self.menuOptionNameArray[indexPath.row])
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
          popup.id = self.menuOptionNameArray[indexPath.row].id
        popup.title = self.menuOptionNameArray[indexPath.row].title
            self.delegate?.sortedViewDidFinished((self.menuOptionNameArray[indexPath.row].id), itemTitle: (self.menuOptionNameArray[indexPath.row].title), price: (self.menuOptionNameArray[indexPath.row].price), indexPath: indexPath)
            self.handleDismiss()
        })
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return   "Select Item"
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 44.0
        }
        return 0.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}

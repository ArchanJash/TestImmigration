//
//  AmentiesView.swift
//  Renzo
//
//  Created by Sonam Verma on 01/10/18.
//  Copyright © 2018 Umesh Verma. All rights reserved.


import UIKit

protocol AmentiesDelegate:class {
    func amentiesDidFinished(_ ids:Array<String>, name: Array<String>,indexPath: IndexPath)
}

class AmentiesView: NSObject,UITableViewDataSource,UITableViewDelegate {
    
    let blackView = UIView()
    let cellID = "cellID"
    
    var selectedCategoryIds : Array = Array<String>()
    var selectedCategoryName : Array = Array<String>()
    weak var delegate: AmentiesDelegate? = nil
    var index:IndexPath? = nil
    
    var menuOptionNameArray : [PopupItem]! {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    lazy var tableView:UITableView = {
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
    
    func showView(_ index:IndexPath,postType:PostType) {
        if let window = UIApplication.shared.keyWindow {
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            blackView.isUserInteractionEnabled = true
            window.addSubview(blackView)
            
            let height:CGFloat = CGFloat(menuOptionNameArray.count + 1) * CGFloat(50)
            let y = window.frame.height - height
            
            tableView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            
            window.addSubview(tableView)
            
            blackView.frame = window.frame
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            blackView.alpha = 0
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 1
                self.tableView.frame = CGRect(x: 0, y: y - 5, width: self.tableView.frame.width, height: self.tableView.frame.height)
            }, completion: nil)
        }
    }
    
    @objc func handleDismiss() {
        
        UIView.animate(withDuration: 0.5, animations: {
            self.blackView.alpha = 0
            if let window = UIApplication.shared.keyWindow {
                self.tableView.frame = CGRect(x: 0, y: window.frame.height, width: self.tableView.frame.width, height: self.tableView.frame.height)
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
        cell.textLabel?.text = menuOptionNameArray[indexPath.row].title
        let id = menuOptionNameArray[indexPath.row].id
        if selectedCategoryIds.contains(id){
            cell.accessoryType = .checkmark
            cell.textLabel?.textColor = UIColor().colorFromHexString(hex: "4C97E5")
        }else{
            cell.accessoryType = .none
            cell.textLabel?.textColor = .gray
        }
        
        if indexPath.row == menuOptionNameArray.count -  1 {
            tableView.separatorStyle = .none
        }else {
            tableView.separatorStyle = .singleLine
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let catid = menuOptionNameArray[indexPath.row].id
        let catName = menuOptionNameArray[indexPath.row].title
        
        if catid == "-1" {
            guard let ind = index else {return}
            self.delegate?.amentiesDidFinished(selectedCategoryIds,name: selectedCategoryName,indexPath: ind)
            self.handleDismiss()
            return
        }else {
            if selectedCategoryIds.contains(catid){
                selectedCategoryIds.remove(at: indexPath.row)
                selectedCategoryName.remove(at: indexPath.row)
            }else{
                selectedCategoryIds.append(catid)
                selectedCategoryName.append(catName)
            }
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Amenties"
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


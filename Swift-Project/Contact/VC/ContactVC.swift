//
//  ContactVC.swift
//  Swift-Project
//
//  Created by 贾金勋 on 2020/5/17.
//  Copyright © 2020 Luke. All rights reserved.
//

import UIKit

class ContactVC: UIViewController {
    var tableView: UITableView?
    var dataSource:[String : Any] = ContactModel().data
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    func setUI() {
        self.view.backgroundColor = UIColorHex_Alpha(0xefefef, al: 1.0)
        tableView = UITableView.init(frame: self.view.frame, style: .plain)
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.backgroundColor = UIColorHex_Alpha(0xefefef, al: 1.0)
        tableView?.separatorInset = UIEdgeInsets.init(top: 0, left: 70, bottom: 0, right: 0)
        tableView?.register(BasicCell.classForCoder(), forCellReuseIdentifier: contact_cell)
        self.view.addSubview(self.tableView!)
        self.tableView!.sectionIndexColor = UIColorHex_Alpha(0x666666, al: 1.0)

        
        let searchBar = UISearchBar.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 60))
        searchBar.barTintColor = UIColorHex_Alpha(0xefefef, al: 1.0)
        searchBar.placeholder = "搜索"
        searchBar.backgroundImage = setImageColor(UIColor.gray, searchBar.bounds.size)
        searchBar.backgroundColor = UIColorHex_Alpha(0xefefef, al: 1.0)
        tableView?.tableHeaderView = searchBar
        
        let rightBtn = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(rightAddContact))
        rightBtn.tintColor = UIColorHex_Alpha(0x333333, al: 1.0)
        self.navigationItem.rightBarButtonItem = rightBtn
    }
    
    @objc func rightAddContact(){
        print("rightAddContact ==")
    }
    
}

extension ContactVC:UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataSource.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let keys = Array(self.dataSource.keys).sorted { (a, b) -> Bool in
            return a < b
        }
        let value = self.dataSource[keys[section]]!
        
        return (value as AnyObject).count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: contact_cell, for: indexPath) as! BasicCell
        let keys = Array(self.dataSource.keys).sorted { (a, b) -> Bool in
            return a < b
        }
        if(indexPath.section == tableView.numberOfSections - 1){
            cell.separatorInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        }
        let value = self.dataSource[keys[indexPath.section]]! as! Array<Any>

        cell.passValue(data: value[indexPath.row] as! [String : String])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return section == 0 ? 0 : 35
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let keys = Array(self.dataSource.keys).sorted { (a, b) -> Bool in
                  return a < b
              }
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 30))
        let label = UILabel.init(frame: CGRect.init(x: 18, y: 3, width: SCREEN_WIDTH - 36, height: 30))
        view.backgroundColor = UIColorHex_Alpha(0xefefef, al: 1.0)
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = keys[section]
        view.addSubview(label)
        return view
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        var keys = Array(self.dataSource.keys).sorted { (a, b) -> Bool in
            return a < b
        }
        keys.removeFirst()
        return keys
    }
    
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return index
    }
}

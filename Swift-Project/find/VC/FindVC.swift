//
//  FindVC.swift
//  Swift-Project
//
//  Created by 贾金勋 on 2020/5/19.
//  Copyright © 2020 Luke. All rights reserved.
//

import UIKit

class FindVC: UIViewController {
    var tableView: UITableView?
    var data:[[[String:String]]] = [
        [
            ["img":"pengyouquan","name":"朋友圈"],
        ],
        [
            ["img":"saoyisao","name":"扫一扫"],
            ["img":"yaoyiyao","name":"摇一摇"]
        ],
        [
            ["img":"kanyikan","name":"看一看"],
            ["img":"souyisou","name":"搜一搜"],
        ],
        [
            ["img":"fujinderen","name":"附近的人"],
        ],
        [
            ["img":"gouwu","name":"购物"],
            ["img":"youxi","name":"游戏"]
        ],
        [
            ["img":"xiaochengxu","name":"小程序"],
        ]
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()

        
    }
    
    func setUI() {
        tableView = UITableView.init(frame: self.view.frame, style: .plain)
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.backgroundColor = UIColorHex_Alpha(0xefefef, al: 1.0)
        tableView?.separatorInset = UIEdgeInsets.init(top: 0, left: 60, bottom: 0, right: 0)
        tableView?.register(FindCell.classForCoder(), forCellReuseIdentifier: find_cell)
        tableView?.tableFooterView = UIView.init()
        self.view.addSubview(tableView!)
    }

}

extension FindVC : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let sub_data = data[section]
        return sub_data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: find_cell, for: indexPath) as! FindCell

        if(indexPath.section == tableView.numberOfSections - 1){
            cell.separatorInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        }
        let sub_data = data[indexPath.section]
        cell.passValue(data: sub_data[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 40))
        view.backgroundColor = UIColorHex_Alpha(0xefefef, al: 1.0)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return section == 0 ? 0 : 10
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.navigationController?.pushViewController(FriendVC(), animated: true)
    }
}

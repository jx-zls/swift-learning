//
//  MineVC.swift
//  Swift-Project
//
//  Created by 贾金勋 on 2020/5/17.
//  Copyright © 2020 Luke. All rights reserved.
//

import UIKit

class MineVC: UIViewController {

    var tableView: UITableView?
    var data:[[[String:String]]] = [
           [
               ["img":"zhifu","name":"支付"],
           ],
           [
               ["img":"shoucang","name":"收藏"],
               ["img":"xiangce","name":"相册"],
               ["img":"kabao","name":"卡包"],
               ["img":"biaoqing","name":"表情"]
           ],
           [
               ["img":"shezhi","name":"设置"]
           ]
       ]
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        
    }
    
}

extension MineVC {
    func setUI() {
        self.view.backgroundColor = UIColorHex_Alpha(0xefefef, al: 1.0)
        self.navigationController?.navigationBar.isHidden = true
        tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT), style: .plain)
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.register(FindCell.classForCoder(), forCellReuseIdentifier: find_cell)
        tableView?.backgroundColor = UIColorHex_Alpha(0xffffff, al: 1.0)
        tableView?.tableFooterView = UIView.init()
        self.view.addSubview(tableView!)
        
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 140))
        headerView.backgroundColor = UIColor.white
        tableView?.tableHeaderView = headerView
        
        let imageV = UIImageView.init()
        imageV.backgroundColor = UIColor.yellow
        headerView.addSubview(imageV)
        imageV.image = UIImage.init(named: "header")
        imageV.snp.makeConstraints { (m) in
            m.width.height.equalTo(60)
            m.left.equalTo(20)
            m.top.equalTo(60)
        }
        
        let nameL = UILabel.init()
        nameL.text = "小明"
        nameL.font = UIFont.systemFont(ofSize: 18)
        headerView.addSubview(nameL)
        nameL.snp.makeConstraints { (m) in
            m.left.equalTo(imageV.snp_right).offset(15)
            m.top.equalTo(imageV.snp_top)
            m.height.equalTo(30)
        }
        
        let detailL = UILabel.init()
        detailL.text = "微信号:nani_001"
        detailL.font = UIFont.systemFont(ofSize: 14)
        detailL.textColor = UIColorHex_Alpha(0xcccccc, al: 1.0)
        headerView.addSubview(detailL)
        detailL.snp.makeConstraints { (m) in
            m.left.equalTo(nameL.snp_left)
            m.top.equalTo(nameL.snp_bottom)
            m.bottom.equalTo(imageV.snp_bottom)
        }
        
        let arrowV = UIImageView()
        headerView.addSubview(arrowV)
        arrowV.image = UIImage.init(named: "arrow")
        arrowV.snp.makeConstraints { (m) in
            m.right.equalTo(-15)
            m.width.equalTo(10)
            m.height.equalTo(15)
            m.centerY.equalTo(detailL.snp_centerY)
        }
        
        let codeV = UIImageView()
        codeV.image = UIImage.init(named: "code")
        headerView.addSubview(codeV)
        codeV.snp.makeConstraints { (m) in
            m.right.equalTo(arrowV.snp_left).offset(-15)
            m.width.height.equalTo(20)
            m.centerY.equalTo(arrowV.snp_centerY)
        }
        
        let navView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 64))
        navView.backgroundColor = UIColor.clear
        self.view.addSubview(navView)
        
        let menuBtn = UIButton.init(type: UIButton.ButtonType.contactAdd)
        navView.addSubview(menuBtn)
        menuBtn.tintColor = UIColorHex_Alpha(0x666666, al: 1.0)
        menuBtn.addTarget(self, action: #selector(menuAction(sender:)), for: UIControl.Event.touchUpInside)
        menuBtn.snp.makeConstraints { (m) in
            m.right.equalTo(-15)
            m.width.equalTo(21)
            m.height.equalTo(20)
            m.centerY.equalTo(navView.snp_centerY).offset(20)
        }
        
    }
    
    @objc func menuAction(sender:UIButton){
        
    }
}

extension MineVC: UITableViewDelegate, UITableViewDataSource {
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
            
            return 10
        }
    }

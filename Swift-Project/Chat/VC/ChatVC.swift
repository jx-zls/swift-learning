//
//  ChatVC.swift
//  Swift-Project
//
//  Created by 贾金勋 on 2020/5/17.
//  Copyright © 2020 Luke. All rights reserved.
//

import UIKit
import SwiftyJSON
import SnapKit
class ChatVC: UIViewController {
    
    var tableView : UITableView?
    var chatModel: ChatModel = ChatModel()
    var searchView: UIView?
    var dataSource: NSMutableArray?
    var navView: UIView?
    var projectView: UIView?
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        getData()
    }
    
}

extension ChatVC {
    func setUI() {
        self.navigationController?.navigationBar.isHidden = true
        self.view!.backgroundColor = UIColorHex_Alpha(0xefefef, al: 1.0)

        self.tableView = UITableView.init(frame: CGRect.init(x: 0, y: 60, width: SCREEN_WIDTH, height:SCREEN_HEIGHT-60), style: UITableView.Style.plain)
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.backgroundColor = UIColorHex_Alpha(0xefefef, al: 1.0)
        self.tableView?.register(ChatCell.classForCoder(), forCellReuseIdentifier: chat_cell)
        self.tableView?.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
        self.tableView?.separatorInset = UIEdgeInsets.init(top: 0, left: 70, bottom: 0, right: 0)
        self.tableView?.separatorColor = UIColorHex_Alpha(0xcccccc, al: 1.0)
        self.view.addSubview(self.tableView!)
        
        let searchBar = UISearchBar.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 60))
        self.searchView = searchBar
        searchBar.placeholder = "搜索"
        searchBar.layer.borderWidth = 1
        searchBar.layer.borderColor =  UIColorHex_Alpha(0xefefef, al: 1.0).cgColor
        searchBar.backgroundColor = UIColorHex_Alpha(0xefefef, al: 1.0)
        searchBar.barTintColor = UIColorHex_Alpha(0xefefef, al: 1.0)
        
        self.tableView!.tableHeaderView = searchView

        
        
        let navView = UIView.init(frame: CGRect.init(x: 0, y: 20, width: SCREEN_WIDTH, height: 44))
        navView.backgroundColor = UIColorHex_Alpha(0xefefef, al: 1.0)
        let titleLabel = UILabel.init()
        titleLabel.text = "聊天"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        self.navView = navView
        self.view.addSubview(navView)
        navView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (m) in
            m.left.equalTo((SCREEN_WIDTH-32)/2)
            m.height.equalTo(44)
        }
        
        let menuBtn = UIButton.init(type: UIButton.ButtonType.contactAdd)
        navView.addSubview(menuBtn)
        menuBtn.tintColor = UIColorHex_Alpha(0x666666, al: 1.0)
        menuBtn.addTarget(self, action: #selector(menuAction(sender:)), for: UIControl.Event.touchUpInside)
        menuBtn.snp.makeConstraints { (m) in
            m.right.equalTo(-15)
            m.width.equalTo(21)
            m.height.equalTo(20)
            m.centerY.equalTo(titleLabel.snp_centerY)
        }
    }
    
    func getData() {
        dataSource = chatModel.getAllData()
    }
    
    @objc func menuAction(sender:UIButton) {
        let titleArray = ["发起群聊","添加朋友","扫一扫","首付款"]
        let menuView = MenuView(frame: CGRect(x: Int(SCREEN_WIDTH) - 140, y: 60 , width: 130, height: titleArray.count*40 - 1), titleArray: titleArray)
        menuView.menuDelegate = self
        
        self.view.window?.addSubview(menuView)
    }
}

extension ChatVC : UITableViewDelegate, UITableViewDataSource, SwiftNoDataShowViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let model = self.dataSource![indexPath.row] as! [String:String]
        let detailVC = ChatDetailVC()
        detailVC.navTitle = model["title"]!
        detailVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(detailVC, animated: true)
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.dataSource != nil) ? self.dataSource!.count : 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: ChatCell = tableView.dequeueReusableCell(withIdentifier: chat_cell, for: indexPath) as! ChatCell
        cell.dicData = JSON(self.dataSource!)[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func didClickSelectedRow(index: Int, title: String, menu: MenuView) {
          menu.removeMenu()
      }
}

extension ChatVC {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y >= 0 && scrollView.contentOffset.y <= 80 {
            scrollView.contentInset = UIEdgeInsets.init(top: -scrollView.contentOffset.y, left: 0, bottom: 0, right: 0)
        }else if scrollView.contentOffset.y >= 80  {
            scrollView.contentInset = UIEdgeInsets.init(top: -80, left: 0, bottom: 0, right: 0)

        }
        searchView!.frame = CGRect.init(x: 0, y: -scrollView.contentOffset.y, width: SCREEN_WIDTH, height: 44)
//        print("searchView ==", searchView!.frame.origin, scrollView.contentOffset.y)

        if scrollView.contentOffset.y <= 0 {
            self.navView?.frame = CGRect.init(x: 0, y: -scrollView.contentOffset.y, width: (self.navView!.bounds.size.width), height: (self.navView!.bounds.size.height))

        }
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {

//        if -scrollView.contentOffset.y >= 150 {
//            UIView.animate(withDuration: 0.2, animations: {
//            }) { (true) in
//                scrollView.setContentOffset(CGPoint.init(x: 0, y: -SCREEN_HEIGHT + 60), animated: true)
//                scrollView.contentInset = UIEdgeInsets.init(top: SCREEN_HEIGHT - 60, left: 0, bottom: 0, right: 0)
//                self.tabBarController?.tabBar.isHidden = true
//                self.projectView?.isHidden = false
//            }
//        }else {
//            UIView.animate(withDuration: 0.2, animations: {
//                self.tabBarController?.tabBar.isHidden = false
//                scrollView.setContentOffset(CGPoint.init(x: 0, y: 0), animated: true)
//                scrollView.contentInset = UIEdgeInsets.init(top: 100, left: 0, bottom: 0, right: 0)
//                }) { (true) in
//                    self.tabBarController?.tabBar.isHidden = false
//                }
//        }
    }
}

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
        
        let navView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH - 10, height: 60))
        navView.backgroundColor = UIColorHex_Alpha(0xefefef, al: 1.0)
        let titleLabel = UILabel.init()
        titleLabel.text = "聊天"
        self.navView = navView
        self.view.addSubview(navView)
        navView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (m) in
            m.left.equalTo((SCREEN_WIDTH-32)/2)
            m.top.equalTo(20)
            m.height.equalTo(40)
        }
    }
    
    func getData() {
        dataSource = chatModel.getAllData()
    }
}

extension ChatVC : UITableViewDelegate, UITableViewDataSource {
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let searchBar = UISearchBar.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 44))
        searchBar.layer.borderWidth = 1
        searchBar.layer.borderColor =  UIColorHex_Alpha(0xefefef, al: 1.0).cgColor
        searchBar.backgroundColor = UIColorHex_Alpha(0xefefef, al: 1.0)
        searchBar.barTintColor = UIColorHex_Alpha(0xefefef, al: 1.0)
        return searchBar
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}

extension ChatVC {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        UIView.animate(withDuration: 5, animations: {
            scrollView.setContentOffset(CGPoint.init(x: 0, y: scrollView.contentOffset.y), animated: true)
        }) { (true) in

        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if scrollView.contentOffset.y >= 0 && scrollView.contentOffset.y <= 80 {
//            scrollView.contentInset = UIEdgeInsets.init(top: -scrollView.contentOffset.y, left: 0, bottom: 0, right: 0)
//        }else if scrollView.contentOffset.y >= 80  {
//            scrollView.contentInset = UIEdgeInsets.init(top: -80, left: 0, bottom: 0, right: 0)
//
//        }
        
        print("scrollViewDidScroll ==", scrollView.contentOffset.y)

        
        if scrollView.contentOffset.y <= 0 {
            self.navView?.frame = CGRect.init(x: 0, y: -scrollView.contentOffset.y, width: (self.navView!.bounds.size.width), height: (self.navView!.bounds.size.height))
            
        }
        
        
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        print("scrollViewDidEndDragging ==", scrollView.contentOffset.y)
        if -scrollView.contentOffset.y >= 150 {
            UIView.animate(withDuration: 0.2, animations: {
            }) { (true) in
//                self.tableView?.contentInset = UIEdgeInsets.init(top: SCREEN_HEIGHT-60, left: 0, bottom: 0, right:0)
                scrollView.setContentOffset(CGPoint.init(x: 0, y: -SCREEN_HEIGHT + 60), animated: true)
                self.tabBarController?.tabBar.isHidden = true
            }
        }else{
             UIView.animate(withDuration: 0.2, animations: {
                }) { (true) in
                    scrollView.setContentOffset(CGPoint.init(x: 0, y: 0), animated: true)
                    self.tabBarController?.tabBar.isHidden = false
                }
        }
    }
}

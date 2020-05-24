//
//  FriendVC.swift
//  Swift-Project
//
//  Created by 贾金勋 on 2020/5/19.
//  Copyright © 2020 Luke. All rights reserved.
//

import UIKit

class FriendVC: UIViewController {
    
    var tableView:UITableView?
    lazy var dataSouce:[MessageModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
        setUI()
    }
    
    func getData() {
        let data = NSData.init(contentsOf: URL.init(fileURLWithPath:Bundle.main.path(forResource: "data", ofType: "json")!))
        
        do {
            let dic : NSDictionary = try JSONSerialization.jsonObject(with: data! as Data, options: .allowFragments) as! NSDictionary
            let rows = ((dic["data"] as! NSDictionary) ["rows"]) as! NSArray
            for (_, value) in rows.enumerated() {
                let messageModel = MessageModel.init()
                messageModel.initWithDic(dic: value as! NSDictionary)
                self.dataSouce.append(messageModel)
            }
            
        }catch{
//            print('异常了====')
        }
       
    }
        
    func setUI() {
        
        self.title = "朋友圈"
        self.view.backgroundColor = UIColor.white
        tableView = UITableView.init(frame: self.view.frame, style: .grouped)
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.backgroundColor = UIColorHex_Alpha(0xffffff, al: 1.0)
        tableView?.separatorStyle = .none
        tableView?.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: friend_cell)
        tableView?.register(HeaderView.classForCoder(), forHeaderFooterViewReuseIdentifier: "headerView")
        tableView?.register(CommentCell.classForCoder(), forCellReuseIdentifier: "commentCell")
        self.view.addSubview(tableView!)
        self.tableView?.snp.makeConstraints({ (m) in
            m.edges.equalTo(0)
        })
    }
}

extension FriendVC:UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return self.dataSouce.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let  messageModel = self.dataSouce[section]
        return messageModel.commentModelArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let messageModel = self.dataSouce[indexPath.section]
        let commentModel =  messageModel.commentModelArray[indexPath.row]
        print("heightForRowAt ==", commentModel.rowHeight!)
        return commentModel.rowHeight!
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let messageMOdel = self.dataSouce[section]
        print("heightForHeaderInSection ==", messageMOdel.headerHeight!)
        return messageMOdel.headerHeight!
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "headerView") as! HeaderView
        let messageModel = self.dataSouce[section]
        headerView.model = messageModel
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10.0
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath) as! CommentCell
        
       let eachModel = self.dataSouce[indexPath.section];
       let commentModel =  eachModel.commentModelArray[indexPath.row];
        cell.model = commentModel
        return cell
    }
}


extension FriendVC {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y >= 0 && scrollView.contentOffset.y <= 80 {
            scrollView.contentInset = UIEdgeInsets.init(top: -scrollView.contentOffset.y, left: 0, bottom: 0, right: 0)
        }else if scrollView.contentOffset.y >= 80  {
            scrollView.contentInset = UIEdgeInsets.init(top: -80, left: 0, bottom: 0, right: 0)

        }
    }

}


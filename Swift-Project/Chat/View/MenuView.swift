//
//  MenuView.swift
//  Swift-Project
//
//  Created by 贾金勋 on 2020/5/18.
//  Copyright © 2020 Luke. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

protocol SwiftNoDataShowViewDelegate  {
    func  didClickSelectedRow(index: Int,title: String,menu: MenuView)
}


class MenuView: UIView, UITableViewDelegate, UITableViewDataSource {

       var titleArray: [String]?
       var tableView: UITableView?
    var reactD: CGRect?
       var menuDelegate: SwiftNoDataShowViewDelegate?
    
       init(frame: CGRect, titleArray: [String]) {
           super.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
           self.titleArray = titleArray
        self.backgroundColor = UIColorHex_Alpha(0x000000, al: 0.2)
        self.reactD = frame
        tableView = UITableView(frame: CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.size.width, height: frame.size.height), style: .plain)
           tableView!.delegate = self
           tableView!.dataSource = self
           tableView!.isScrollEnabled = false
           tableView!.layer.masksToBounds = true
           tableView!.layer.cornerRadius = 6
           tableView?.backgroundColor = UIColorHex_Alpha(0x333333, al: 1.0)
           tableView!.separatorStyle = .none
           tableView?.register(MenuCell.classForCoder(), forCellReuseIdentifier: menu_cell)
           self.addSubview(tableView!)
        
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapAction))
        self.addGestureRecognizer(tap)
        

       }
    @objc func tapAction() {
        removeMenu()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {

        //绘制小三角形
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        let x = (self.reactD?.origin.x)!
        let y = (self.reactD?.origin.y)!
        let wid = self.reactD!.width - 15

        let path = CGMutablePath()
        //设立设置的三角形在中间，具体位置可以自定
        path.move(to: CGPoint(x: (x + wid - 6), y: y))
        path.addLine(to: CGPoint(x: x+wid + 6, y: y))
        path.addLine(to: CGPoint(x: wid + x, y: y - 6))
        context.setFillColor(UIColorHex_Alpha(0x333333, al: 1.0).cgColor)
        context.addPath(path)
        context.fillPath()
        //设置tableView的frame，用于动画效果
//        tableView?.frame = CGRect(x: 0, y: 8, width: frame.size.width, height: frame.size.height-8)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (titleArray?.count)!
    }
    
    
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: menu_cell, for: indexPath) as! MenuCell
        cell.passValue(url: "", title: titleArray![indexPath.row])
           return cell
       }
       //单击事件的Delegate回调
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           menuDelegate?.didClickSelectedRow(index: indexPath.row, title: self.titleArray![indexPath.row], menu: self)
       }
       //cell的高度
       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 40
       }
       //移除menu的动画，透明度渐变效果
       func removeMenu(){
        UIView.animate(withDuration: 0.5, animations: {
               self.alpha = 0
           }) { (finish) in
               self.removeFromSuperview()
           }
       }
}



class MenuCell: UITableViewCell {
    var imageV: UIImageView?
    var titleL: UILabel?
    var lineL: UILabel?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    func passValue(url:String, title:String)  {
//        imageV?.kf.setImage(with: ImageResource.init(downloadURL: URL.init(string: url)!))
        titleL?.text = title
    }
    
    func setUI() {
        self.contentView.backgroundColor = UIColorHex_Alpha(0x333333, al: 1.0)
        imageV = UIImageView()
        self.contentView.addSubview(imageV!)
        imageV?.snp.makeConstraints({ (m) in
            m.width.height.equalTo(30)
            m.left.equalTo(10)
            m.centerY.equalTo(self.contentView.snp_centerY)
        })
        
        titleL = UILabel()
        titleL?.textColor = UIColorHex_Alpha(0xffffff, al: 0.8)
        titleL?.font = UIFont.systemFont(ofSize: 12)
        self.contentView.addSubview(titleL!)
        titleL?.snp.makeConstraints({ (m) in
            m.left.equalTo(self.imageV!.snp_right).offset(5)
            m.right.equalTo(self.contentView.snp_right).offset(-5)
            m.height.equalTo(30)
            m.centerY.equalTo(self.imageV!.snp_centerY)
            
        })
        
        lineL = UILabel()
        lineL?.backgroundColor = UIColor.white
        self.contentView.addSubview(lineL!)
        lineL?.snp.makeConstraints({ (m) in
            m.left.equalTo(titleL!.snp_left)
            m.bottom.equalTo(self.contentView.snp_bottom)
            m.height.equalTo(0.3)
            m.right.equalTo(0)

        })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



//
//  HeaderView.swift
//  Swift-Project
//
//  Created by 贾金勋 on 2020/5/19.
//  Copyright © 2020 Luke. All rights reserved.
//

import UIKit
import Kingfisher

typealias TapBlock = (_ index:Int, _ dataSource:[String])->Void

typealias CommentBlock = (_ btn:UIButton, _ headersec:Int) -> Void
typealias MoreBtnClickBlock = (_ moreBtn:UIButton, _ isExtend:Bool) -> Void


class HeaderView: UITableViewHeaderFooterView {


    
    var tapBlock:TapBlock?
    var commentBtnWidth:CGFloat?
    var commentBtnHeight:CGFloat?
    var MaxLabelHeight:CGFloat?
    
    var sepLine:UILabel?
    var avatarIV:UIImageView?
    var userNameLabel:UILabel?
    var timeStampLabel:UILabel?
    var messageTextLabel:UILabel?
    var commentBtn:UIButton?
    var moreBtn:UIButton?
    var isExpandNow:Bool?
    var headerSection:Int?
    var jggView:JGGView?
    
    var commentBlock:CommentBlock?
    var moreBlock:MoreBtnClickBlock?
    
    
    var model:MessageModel! {
        didSet {
            self.avatarIV?.kf.setImage(with: ImageResource.init(downloadURL: URL.init(string: model.photo!)!))
            self.userNameLabel?.text = model.userName
            self.messageTextLabel?.attributedText = model.mutablAttrStr
            self.messageTextLabel?.frame = model.textLayout!
            self.jggView?.subviews.forEach { $0.removeFromSuperview() }
            self.jggView?.dataSource = model.messageSmallPics
            self.jggView?.frame = model.jggLayout!
        }
    }
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = UIColor.white
        self.sepLine = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 1.0/UIScreen.main.scale))
        self.addSubview(self.sepLine!)
        
        self.avatarIV = UIImageView.init(frame: CGRect.init(x: 10, y: 10, width: 40, height: 40))
        self.addSubview(self.avatarIV!)
        self.avatarIV?.layer.cornerRadius = 3
        self.avatarIV?.layer.masksToBounds = true
        self.userNameLabel = UILabel.init(frame: CGRect.init(x: (self.avatarIV?.frame.maxX)!+10, y: 10, width: SCREEN_WIDTH - 40 - 30, height: self.avatarIV!.frame.size.height / 2))
        self.userNameLabel?.font = UIFont.systemFont(ofSize: 16.0)
        self.userNameLabel?.textColor = UIColor.init(red: 54/255, green: 71/255, blue: 121/255, alpha: 0.9)
        self.addSubview(self.userNameLabel!)
        
        self.timeStampLabel = UILabel.init()
        self.timeStampLabel?.font = UIFont.systemFont(ofSize: 12.0)
        self.timeStampLabel?.textColor = UIColor.lightGray
        self.addSubview(self.timeStampLabel!)
        
        self.messageTextLabel = UILabel.init()
        self.messageTextLabel?.numberOfLines = 0
        self.messageTextLabel?.lineBreakMode = .byCharWrapping
        self.messageTextLabel?.font = UIFont.systemFont(ofSize: 14.0)
        self.addSubview(self.messageTextLabel!)
        
        
        commentBtnWidth = 60;
        commentBtnHeight = 22;
        MaxLabelHeight = 75.0;
        
        self.commentBtn = UIButton.init(type: .custom)
        self.commentBtn?.backgroundColor = UIColor.white
        self.commentBtn?.setTitle("评论", for: .normal)
        self.commentBtn?.layer.borderColor = UIColor.lightGray.cgColor
        self.commentBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 12.0)
        self.commentBtn?.layer.borderWidth = 1
        self.commentBtn?.addTarget(self, action: #selector(commentAction), for: .touchUpOutside)
        self.addSubview(self.commentBtn!)
        
        self.moreBtn = UIButton.init(type:.custom)
        self.moreBtn?.setTitle("全文", for: .normal)
        self.moreBtn?.setTitle("收起", for: .selected)
        self.moreBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 12.0)
        self.moreBtn?.addTarget(self, action: #selector(moreAction), for: .touchUpOutside)
        self.addSubview(self.moreBtn!)
        self.isExpandNow = false
        self.jggView = JGGView.init()
        self.addSubview(self.jggView!)
    }
    
    @objc func moreAction() {
        if((self.moreBlock) != nil){
            self.moreBlock!(self.moreBtn!, self.isExpandNow!)
        }
    }
    
    @objc func commentAction() {
        if((self.commentBtn) != nil){
            self.commentBlock!(self.commentBtn!, self.headerSection!)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

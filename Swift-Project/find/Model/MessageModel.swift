//
//  MessageModel.swift
//  Swift-Project
//
//  Created by 贾金勋 on 2020/5/19.
//  Copyright © 2020 Luke. All rights reserved.
//

import UIKit

class MessageModel: NSObject {

    var cid: String?
    var message_id: String?
    var message: String?
    var isExpand: Bool?
    var timeTag: String?
    var message_type: String?
    var userId: String?
    var userName: String?
    var photo: String?
    lazy var messageSmallPics: [String] = []
    lazy var messageBigPics: [String] = []
    lazy var commentModelArray: [CommentModel] = []
    var headerHeight: CGFloat?
    var textLayout: CGRect?
    var jggLayout: CGRect?
    var mutablAttrStr: NSMutableAttributedString?

    override init() {
        super.init()
    }
    func initWithDic(dic:NSDictionary) {
        
        self.cid                = dic["cid"] as? String
        self.message_id         = dic["message_id"] as? String
        self.message            = dic["message"] as? String
        self.timeTag            = dic["timeTag"] as? String
        self.message_type       = dic["message_type"] as? String
        self.userId             = dic["userId"] as? String
        self.userName           = dic["userName"] as? String
        self.photo              = dic["photo"] as? String
        self.messageSmallPics   = (dic["messageSmallPics"] as? [String])!
        self.messageBigPics     = (dic["messageBigPics"] as? [String])!
        
        var likeUser:[FriendInfo] = []
        for (index,dic) in (dic["likeUsers"] as! [[String : String]]).enumerated() {
            let friendModel = FriendInfo()
            friendModel.initWithDic(dic: dic as NSDictionary)
            likeUser.append(friendModel)
        }
        
        if(likeUser.count > 0){
            let commentModel = CommentModel.init()
//            commentModel.initDic(dic: dic)
            commentModel.likeUsersArray = likeUser
            var rangesArray:[NSValue] = []
            var nameArray:[String] = []
            let mutablAttrStr = NSMutableAttributedString()
            let attch = NSTextAttachment()
            attch.image = UIImage.init(named: "Like")
            attch.bounds = CGRect.init(x: 0, y: -5, width: attch.image!.size.width, height: attch.image!.size.height)
            mutablAttrStr.insert(NSAttributedString.init(attachment: attch), at: 0)
            
            for (index, model) in likeUser.enumerated() {
                mutablAttrStr.append(NSAttributedString.init(string: model.userName!))
                if(nameArray.contains(model.userName!)){
                    model.range = NSRange.init(location: mutablAttrStr.length-model.userName!.count, length: model.userName!.count)
                   
                }else{
                    let str : NSString = mutablAttrStr.string as NSString
                    model.range = str.range(of: model.userName!)
        
                }
                
                if(index != likeUser.count - 1){
                    mutablAttrStr.append(NSAttributedString.init(string: ","))
                }
                
                rangesArray.append(NSValue.init(range: model.range!))
                nameArray.append(model.userName!)
                let font = UIFont.systemFont(ofSize: 14.0)
                mutablAttrStr.addAttributes([NSAttributedString.Key.font : font], range: NSRange.init(location: 0, length: mutablAttrStr.length))
                
                let paragraphy = NSMutableParagraphStyle.init()
                paragraphy.lineSpacing = 3.0
                mutablAttrStr.addAttributes([NSAttributedString.Key.paragraphStyle : paragraphy], range: NSRange.init(location: 0, length: mutablAttrStr.length))
                
                for (_, value) in rangesArray.enumerated() {
                    mutablAttrStr.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.orange], range: value.rangeValue)
                }
                commentModel.likeUsersAttributedText = mutablAttrStr
                commentModel.rowHeight = mutablAttrStr.string.boundingRectWithSize(size: CGSize.init(width: SCREEN_WIDTH - 40 - 20, height: CGFloat.greatestFiniteMagnitude) , font: font, lineSpacing: paragraphy.lineSpacing).height+0.5+8+5
                
            }
        }
        
        
        for (index, value) in (dic["commentMessages"] as! NSArray).enumerated() {
            let commentModel = CommentModel()
            commentModel.initDic(dic: value as! NSDictionary)
            self.commentModelArray.append(commentModel)
        }
        let perrgraphy = NSMutableParagraphStyle.init()
       let font = UIFont.systemFont(ofSize: 14.0)
       perrgraphy.alignment = .left
       let mutString = NSMutableAttributedString.init(string: self.message!)
       mutString.addAttributes([NSAttributedString.Key.font : font, .paragraphStyle:perrgraphy], range: NSRange.init(location: 0, length: mutString.length))
       if(mutString.string.isMoreThanOneLineWithSize(size: CGSize.init(width:  SCREEN_WIDTH - 40 - 20, height: CGFloat.greatestFiniteMagnitude), font: font, linespacing: 3.0)){
           perrgraphy.lineSpacing = 3.0
       }else{
           perrgraphy.lineSpacing = CGFloat.leastNormalMagnitude
       }
        self.mutablAttrStr = mutString
        
        let textHeight = mutString.string.boundingRectWithSize(size: CGSize.init(width:  SCREEN_WIDTH - 40 - 20, height: CGFloat.greatestFiniteMagnitude), font: font, lineSpacing: 3.0).height + 0.5
        self.textLayout = CGRect.init(x: 60, y: 35, width: SCREEN_WIDTH - 70, height: textHeight)
        
        let jgg_width = SCREEN_WIDTH - 20 - 40 - 50
        let image_Width = (jgg_width - 20)/3
        var jgg_height = 0
        print("jgg_height ==", self.messageSmallPics.count)
        if(self.messageSmallPics.count == 0){
            jgg_height = 0
        }else if(self.messageSmallPics.count<=3){
            jgg_height = Int(image_Width)
        }else if (self.messageSmallPics.count>3&&self.messageSmallPics.count<=6){
            jgg_height = Int(2*image_Width+10)
        }else if(self.messageSmallPics.count>6&&self.messageSmallPics.count<=9){
            jgg_height = Int(3*image_Width+2*10)
        }
        self.jggLayout = CGRect.init(x: (self.textLayout?.origin.x)!, y: self.textLayout!.maxY+10, width: jgg_width, height: CGFloat(jgg_height))
        let mar = (self.messageSmallPics.count == 0) ? 0 : 10
        self.headerHeight = self.jggLayout!.maxY + CGFloat(mar)
        
    }
    
    
}


extension String {
    func isMoreThanOneLineWithSize(size:CGSize, font:UIFont, linespacing:CGFloat) -> Bool {
        if(self.boundingRectWithSize(size: size, font: font, lineSpacing: linespacing).height > font.lineHeight){
            return true
        }
        return false
    }
    
    func boundingRectWithSize(size:CGSize, font:UIFont, lineSpacing:CGFloat) -> CGSize {
        let attributeString = NSMutableAttributedString.init(string: self)
        let paragraphStyle = NSMutableParagraphStyle.init()
        paragraphStyle.lineSpacing = lineSpacing
        attributeString.addAttributes([.font:font, .paragraphStyle:paragraphStyle], range: NSRange.init(location: 0, length: self.count))
        let options = NSStringDrawingOptions.usesLineFragmentOrigin
        var rect = attributeString.boundingRect(with: size, options: options, context: nil)
        if((rect.size.height - font.lineHeight) <= paragraphStyle.lineSpacing){
            if (self.containChinese(str: self)) {  //如果包含中文
                rect = CGRect.init(x: rect.origin.x, y: rect.origin.y, width: rect.size.width, height: rect.size.height - paragraphStyle.lineSpacing)
           }
        }
        
        return rect.size
    }
    
    func containChinese(str:String) -> Bool {
//        for index in str.enumerated() {
////            if( < 0x9fff && chat > 0x4e00){
////                return true
////            }
//        }
        return false
    }
    
}

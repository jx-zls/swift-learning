//
//  CommentModel.swift
//  Swift-Project
//
//  Created by 贾金勋 on 2020/5/19.
//  Copyright © 2020 Luke. All rights reserved.
//

import UIKit

class CommentModel: NSObject {
    var isExpand: Bool?
    var commentId: String?
    var commentUserId: String?
    var commentUserName: String?
    var commentPhoto: String?
    var commentText: String?
    var attributedText: NSAttributedString?
    var commentByUserId: String?
    var commentByUserName: String?
    var commentByPhoto: String?
    var createDateStr: String?
    var checkStatus: String?
    var messageBigPicArray: [String] = []
    var likeUsersAttributedText: NSMutableAttributedString?
    var likeUsersArray: [FriendInfo] = []
    var commentModelArray: [CommentModel] = []
    var rowHeight: CGFloat?
    
    
    func initDic(dic:NSDictionary) {
        
        self.commentId          = dic["commentId"] as? String
        self.commentUserId      = dic["commentUserId"] as? String
        self.commentUserName    = dic["commentUserName"] as? String
        self.commentPhoto       = dic["commentPhoto"] as? String
        self.commentText        = dic["commentText"] as? String
        self.commentByUserId    = dic["commentByUserId"] as? String
        self.commentByUserName  = dic["commentByUserName"] as? String
        self.commentByPhoto     = dic["commentByPhoto"] as? String
        self.createDateStr      = dic["createDateStr"] as? String
        self.checkStatus        = dic["checkStatus"] as? String
        
        var str: String? = nil
        if(self.commentByUserName != ""){
            str = "\(commentUserName!)回复\(commentByUserName!): \(commentText!)"
        }else{
            str = "\(commentUserName!):\(self.commentText!)"
        }
        
        let mutString = NSMutableAttributedString.init(string: str!)
        mutString.addAttributes([.foregroundColor:UIColor.orange], range: NSRange.init(location: 0, length: commentUserName!.count))
        mutString.addAttributes([.foregroundColor:UIColor.orange], range: NSRange.init(location: commentUserName!.count + 2, length: commentByUserName!.count))
        mutString.addAttributes([.font:UIFont.systemFont(ofSize: 13.0)], range: NSRange.init(location: 0, length: mutString.length))
        
        let style = NSMutableParagraphStyle.init()
        if(mutString.string.isMoreThanOneLineWithSize(size:CGSize.init(width: SCREEN_WIDTH - 30 - 40, height: CGFloat.greatestFiniteMagnitude), font: UIFont.systemFont(ofSize: 13.0), linespacing: 3.0)){
            style.lineSpacing = 3
        }else{
            style.lineSpacing = CGFloat.leastNormalMagnitude
        }
        mutString.addAttributes([.paragraphStyle:style], range: NSRange.init(location: 0, length: mutString.length))
        self.rowHeight = mutString.string.boundingRectWithSize(size: CGSize.init(width: SCREEN_WIDTH - 70, height: CGFloat.greatestFiniteMagnitude), font: UIFont.systemFont(ofSize: 13), lineSpacing: 3.0).height + 3.5
        self.attributedText = mutString
        
        
    }

}

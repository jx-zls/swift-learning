//
//  FriendInfo.swift
//  Swift-Project
//
//  Created by 贾金勋 on 2020/5/20.
//  Copyright © 2020 Luke. All rights reserved.
//

import UIKit

class FriendInfo: NSObject {
    var imageName:String?
    var userName:String?
    var userId:String?
    var photo:String?
    var phoneNO:String?
    var range:NSRange?
    func initWithDic(dic:NSDictionary) {
        
        self.userId      = dic["userId"] as? String
        self.userName    = dic["userName"] as? String
        self.photo       = dic["photo"] as? String
        self.phoneNO     = dic["phoneNO"] as? String
    }
}

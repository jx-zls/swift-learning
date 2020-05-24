//
//  ContactModel.swift
//  Swift-Project
//
//  Created by 贾金勋 on 2020/5/18.
//  Copyright © 2020 Luke. All rights reserved.
//

import UIKit

class ContactModel: NSObject {

    var data:[String: [[String:String]]] = [
        "0":[
            ["img":"newfriend","name":"新的朋友"],
            ["img":"group","name":"群聊"],
            ["img":"element","name":"标签"],
            ["img":"gzh","name":"公众号"]
        ],
        "A":[
            ["img":"user3","name":"贾少"]
        ],
        "N":[
            ["img":"niuniu","name":"二妞"]
        ],
        "W":[
              ["img":"user4","name":"刘少"],
              ["img":"wxtd","name":"微信团队"]
        ],
        "Z":[
            ["img":"user1","name":"张三"],
            ["img":"user5","name":"张小张"]
        ],
        
    ]
}

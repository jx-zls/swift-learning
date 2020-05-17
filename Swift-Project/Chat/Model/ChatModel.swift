//
//  ChatModel.swift
//  Swift-Project
//
//  Created by 贾金勋 on 2020/5/17.
//  Copyright © 2020 Luke. All rights reserved.
//

import UIKit

class ChatModel: NSObject {
    var dic = [
        "time":"三天前",
        "title":"菜鸟互啄",
        "detail":"一群菜鸟互啄",
        "icon":""
    ]
    
    func getAllData() -> NSMutableArray {
        let dataArr = NSMutableArray.init()
        for _ in 1...10 {
            dataArr.add(dic)
        }
        return dataArr
    }
}

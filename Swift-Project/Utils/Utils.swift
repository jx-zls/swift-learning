//
//  Utils.swift
//  Swift-Project
//
//  Created by 贾金勋 on 2020/5/17.
//  Copyright © 2020 Luke. All rights reserved.
//

import UIKit

class Utils: NSObject {

}

let chat_cell = "chatCell"
public let SCREEN_WIDTH = UIScreen.main.bounds.size.width
public let SCREEN_HEIGHT = UIScreen.main.bounds.size.height

func UIColorHex_Alpha (_ rgbValue:Int,  al:CGFloat) -> UIColor  {
    
    return UIColor.init(red: ((CGFloat)((rgbValue & 0xFF0000) >> 16))/255.0, green: ((CGFloat)((rgbValue & 0xFF00) >> 8))/255.0, blue: ((CGFloat)(rgbValue & 0xFF))/255.0, alpha: al)
}

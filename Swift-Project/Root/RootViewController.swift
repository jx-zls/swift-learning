//
//  RootViewController.swift
//  Swift-Project
//
//  Created by 贾金勋 on 2020/5/17.
//  Copyright © 2020 Luke. All rights reserved.
//

import UIKit

class RootViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }

}

extension RootViewController {
    func setUI() {
        self.view.backgroundColor = UIColor.white
        let vc = [
            ChatVC(),
            ContactVC(),
            MineVC()
        ]
        
        let title = [
            "聊天",
            "联系人",
            "我的"
        ]
        
        for (index, childvc) in vc.enumerated() {
            childvc.title = title[index]
            childvc.tabBarItem.title = title[index]
            addChild(UINavigationController.init(rootViewController: childvc))
        }
        
    }
}

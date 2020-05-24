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
        
        let tabBar = UITabBarItem.appearance()
        let attrs_Normal = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10), NSAttributedString.Key.foregroundColor: UIColorHex_Alpha(0x707070, al: 1.0 )]//未点击颜色
        let attrs_Select = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10), NSAttributedString.Key.foregroundColor: UIColorHex_Alpha(0x1afa29, al: 1.0)]//点击后颜色
       tabBar.setTitleTextAttributes(attrs_Normal, for: .normal)
       tabBar.setTitleTextAttributes(attrs_Select, for: .selected)
        
        
        let backImage = UIImage.init(named: "back3")?.withRenderingMode(.alwaysOriginal)
        let appearance = UINavigationBar.appearance()
        appearance.backIndicatorImage = backImage
        appearance.backIndicatorTransitionMaskImage = backImage
        
    }

}

extension RootViewController {
    func setUI() {
        self.view.backgroundColor = UIColor.white
        let vc = [
            ChatVC(),
            ContactVC(),
            FindVC(),
            MineVC()
        ]
        
        let title = [
            ("聊天","liaotian"),
            ("通讯录","tongxunlu"),
            ("发现","faxian"),
            ("我的","wo")
        ]
        
        for (index, childvc) in vc.enumerated() {
            childvc.title = title[index].0
            childvc.tabBarItem.selectedImage = UIImage.init(named: title[index].1)!.withRenderingMode(.alwaysOriginal)
            childvc.tabBarItem.image = UIImage.init(named: "\(title[index].1)2")?.withRenderingMode(.alwaysOriginal)
            childvc.tabBarItem.title = title[index].0
            childvc.tabBarItem.imageInsets = UIEdgeInsets.init(top: 2, left: 2, bottom: 2, right: 2)
            let nav = UINavigationController.init(rootViewController: childvc)
//            nav.navigationBar.barTintColor = UIColorHex_Alpha(0xefefef, al: 1.0)
            nav.navigationBar.barTintColor = UIColorHex_Alpha(0xefefef, al: 1.0)
            nav.navigationBar.shadowImage = UIImage()
            addChild(nav)
        }
        
    }
}
extension UINavigationController:UINavigationBarDelegate {
//    open override class func load() {
//
//    }
    
    public func navigationBar(_ navigationBar: UINavigationBar, shouldPush item: UINavigationItem) -> Bool {
        let leftBarItem = UIBarButtonItem.init(title: "", style: .plain, target: nil, action: nil)
        item.backBarButtonItem = leftBarItem
        return true
    }
    
    
}

//
//  JGGView.swift
//  Swift-Project
//
//  Created by 贾金勋 on 2020/5/20.
//  Copyright © 2020 Luke. All rights reserved.
//

import UIKit
import Kingfisher

class JGGView: UIView {
    
   
    var block:TapBlock?
    
    var dataSource:[Any] = [] {
        didSet {
            let jgg_width = SCREEN_WIDTH-2*10-40-50
            let image_width = (jgg_width-2*10)/3
            let image_height = image_width
            
            for (index, value) in dataSource.enumerated() {
                let imageV = YYAnimatedImageView.init(frame: CGRect.init(x: (0+(image_width+10)*(CGFloat(index%3))), y: (CGFloat(floorf(Float(index)/3.0))*(image_height+10)), width: image_width, height: image_height))
                if((value as AnyObject).isKind(of: UIImage.classForCoder())){
                    imageV.image = (value as! UIImage)
                }else if((value as AnyObject).isKind(of:NSString.classForCoder())) {
                    imageV.kf.setImage(with: ImageResource.init(downloadURL: URL.init(string: value as! String)!))
                }else if((value as AnyObject).isKind(of:NSURL.classForCoder())){
                    imageV.kf.setImage(with: ImageResource.init(downloadURL: value as! URL))
                }
                
                imageV.isUserInteractionEnabled = true
                imageV.tag = index
                imageV.autoPlayAnimatedImage = true
                self.addSubview(imageV)
                
            }
        }
    }
    

}

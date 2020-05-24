//
//  ProjectCell.swift
//  Swift-Project
//
//  Created by 贾金勋 on 2020/5/18.
//  Copyright © 2020 Luke. All rights reserved.
//

import UIKit

class ProjectCell: UICollectionViewCell {
    
    var titleL: UILabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 40, height: 40))
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    func passValue(index:Int) {
        titleL.text = String(index)
    }
    
   private func setUI() {
        self.contentView.addSubview(titleL)
    }
}

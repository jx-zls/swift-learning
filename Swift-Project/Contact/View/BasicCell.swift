//
//  BasicCell.swift
//  Swift-Project
//
//  Created by 贾金勋 on 2020/5/18.
//  Copyright © 2020 Luke. All rights reserved.
//

import UIKit
import SnapKit
import SwiftyJSON

class BasicCell: UITableViewCell {
    
    var imageV:UIImageView?
    var titleL:UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUI()
    }
    
    func passValue(data:[String:String]) {
        imageV?.image = UIImage.init(named: data["img"]!)
        titleL?.text = data["name"]
        
    }
    
    func setUI() {
        self.backgroundColor = UIColorHex_Alpha(0xffffff, al: 1.0)
        imageV = UIImageView()
        imageV?.layer.masksToBounds = true
        imageV?.layer.cornerRadius = 4.0
        self.contentView.addSubview(imageV!)
        imageV?.snp.makeConstraints({ (m) in
            m.width.height.equalTo(40)
            m.centerY.equalTo(self.contentView.snp.centerY)
            m.left.equalTo(15)
        })
        
        titleL = UILabel()
        self.contentView.addSubview(titleL!)
        titleL?.textColor = UIColorHex_Alpha(0x333333, al: 1.0)
        titleL?.font = UIFont.systemFont(ofSize: 14)
        titleL?.snp.makeConstraints({ (m) in
            m.left.equalTo(imageV!.snp_right).offset(10)
            m.height.equalTo(30)
            m.centerY.equalTo(imageV!.snp_centerY)
        })
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

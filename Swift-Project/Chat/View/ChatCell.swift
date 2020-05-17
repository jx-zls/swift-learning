//
//  ChatCell.swift
//  Swift-Project
//
//  Created by 贾金勋 on 2020/5/17.
//  Copyright © 2020 Luke. All rights reserved.
//

import UIKit
import SnapKit
import SwiftyJSON
import Kingfisher


class ChatCell: UITableViewCell {
    lazy var iconImageV : UIImageView = UIImageView()
    lazy var titleL : UILabel = UILabel()
    lazy var detailL : UILabel = UILabel()
    lazy var timeL : UILabel = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
     var dicData : JSON! {
        didSet {
            self.imageView?.image = UIImage.init(named: "chat_cell")
            titleL.text = dicData["title"].string
            detailL.text = dicData["detail"].string
            timeL.text = dicData["time"].string
        }
    }
    
    func setUI() {
        imageView?.layer.masksToBounds = true
        imageView?.layer.cornerRadius = 8
        self.contentView.addSubview(iconImageV)
        iconImageV.snp.makeConstraints { (m) in
            m.width.equalTo(50)
            m.height.equalTo(50)
            m.left.equalTo(10)
            m.centerY.equalTo(self.contentView.snp_centerY)
        }
        
        titleL.font = UIFont.boldSystemFont(ofSize: 14)
        self.contentView.addSubview(titleL)
        titleL.snp.makeConstraints { (m) in
            m.right.equalTo(-80)
            m.left.equalTo(70)
            m.height.equalTo(25)
            m.top.equalTo(10)
        }
        detailL.textColor = UIColorHex_Alpha(0x6666666, al: 1.0)
        detailL.font = UIFont.systemFont(ofSize: 12)
        self.contentView.addSubview(detailL)
        detailL.snp.makeConstraints { (m) in
            m.right.equalTo(-10)
            m.left.equalTo(70)
            m.bottom.equalTo(self.contentView.snp_bottom).offset(-5)
            m.top.equalTo(titleL.snp_bottom).offset(5)
        }
        
        timeL.textColor = UIColorHex_Alpha(0x666666, al: 1.0)
        timeL.font = UIFont.systemFont(ofSize: 12)
        self.contentView.addSubview(timeL)
        timeL.snp.makeConstraints { (m) in
            m.right.equalTo(self.contentView.snp_right).offset(-5)
            m.left.equalTo(titleL.snp_right).offset(5)
            m.bottom.equalTo(titleL.snp_bottom)
            m.top.equalTo(titleL.snp_top)
        }
    }
}

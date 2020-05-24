//
//  CommentCell.swift
//  Swift-Project
//
//  Created by 贾金勋 on 2020/5/19.
//  Copyright © 2020 Luke. All rights reserved.
//

import UIKit
import SnapKit

class CommentCell: UITableViewCell {

   
    var conenteLabel : UILabel?
    
    var model : CommentModel! {
        didSet {
            if(model.isKind(of: CommentModel.self)){
                self.conenteLabel?.attributedText = model.attributedText
            }else{
                self.conenteLabel?.text = "数组"
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none;
        self.conenteLabel = UILabel.init()

        self.conenteLabel?.preferredMaxLayoutWidth = SCREEN_WIDTH - 70
        self.conenteLabel?.lineBreakMode = .byCharWrapping
        self.conenteLabel?.numberOfLines = 0
        self.conenteLabel?.font = UIFont.systemFont(ofSize: 13.0)
        self.contentView.addSubview(self.conenteLabel!)

        self.conenteLabel?.snp.makeConstraints({ (m) in
            m.edges.equalTo(self.contentView).inset(UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0))
        })
    }
    
    override var frame: CGRect {
        didSet {
            var newFrame = frame
            let leftSpace = 2*10+40
            newFrame.origin.x = CGFloat(leftSpace);
            newFrame.size.width = SCREEN_HEIGHT - CGFloat(leftSpace) - 10;
            super.frame = newFrame

        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

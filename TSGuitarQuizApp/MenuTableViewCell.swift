//
//  MenuTableViewCell.swift
//  TSGuitarQuizApp
//
//  Created by nttr on 2017/07/20.
//  Copyright © 2017年 nttr. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {
    
    // メニュー画像
    @IBOutlet var menuIcon : UIImageView!
    
    // メニュータイトル
    @IBOutlet var menuTitleLabel : UILabel!
  
    // メニュー説明
    @IBOutlet var menuExplanationTextView : UITextView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

//
//  LevelSelectTableViewCell.swift
//  TSGuitarQuizApp
//
//  Created by nttr on 2017/07/20.
//  Copyright © 2017年 nttr. All rights reserved.
//

import UIKit

class QuizTypeSelectTableViewCell: UITableViewCell {

    // メニュー画像
    @IBOutlet var quizTypeSelectIcon : UIImageView!
    
    // メニュータイトル
    @IBOutlet var quizTypeSelectTitleLabel : UILabel!
    
    // メニュー説明
    @IBOutlet var quizTypeSelectExplanationTextView : UITextView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

//
//  Fret2ToneTableViewCell.swift
//  TSGuitarQuizApp
//
//  Created by nttr on 2017/07/20.
//  Copyright © 2017年 nttr. All rights reserved.
//

import UIKit

class QuizFret2ToneTableViewCell: UITableViewCell {
    
    // 選択状態画像
    @IBOutlet var quizFret2ToneIsCheckedImageView : UIImageView!
    
    // 選択肢名称
    @IBOutlet var quizFret2ToneAnswerLabel : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

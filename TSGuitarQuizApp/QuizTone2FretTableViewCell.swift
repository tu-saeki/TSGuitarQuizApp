//
//  Tone2FretTableViewCell.swift
//  TSGuitarQuizApp
//
//  Created by nttr on 2017/07/20.
//  Copyright © 2017年 nttr. All rights reserved.
//

import UIKit

class QuizTone2FretTableViewCell: UITableViewCell {
    
    // 選択肢のラベル名
    @IBOutlet var quizTextLabel : UILabel!
    
    // フレットIDの表示ラベル
    @IBOutlet var quizTone2FretFretId1Label : UILabel!
    @IBOutlet var quizTone2FretFretId2Label : UILabel!
    @IBOutlet var quizTone2FretFretId3Label : UILabel!
    
    // 弦IDの表示ラベル
    @IBOutlet var quizTone2FretStringId1Label : UILabel!
    @IBOutlet var quizTone2FretStringId2Label : UILabel!
    @IBOutlet var quizTone2FretStringId3Label : UILabel!
    @IBOutlet var quizTone2FretStringId4Label : UILabel!
    @IBOutlet var quizTone2FretStringId5Label : UILabel!
    @IBOutlet var quizTone2FretStringId6Label : UILabel!
    
    // 各弦IDの解放表示ラベル
    @IBOutlet var quizTone2FretOpenStringId1Label : UILabel!
    @IBOutlet var quizTone2FretOpenStringId2Label : UILabel!
    @IBOutlet var quizTone2FretOpenStringId3Label : UILabel!
    @IBOutlet var quizTone2FretOpenStringId4Label : UILabel!
    @IBOutlet var quizTone2FretOpenStringId5Label : UILabel!
    @IBOutlet var quizTone2FretOpenStringId6Label : UILabel!
    
    // 弦のアイコン表示ラベル
    @IBOutlet var quizTone2FretFret11ImageView : UIImageView!
    @IBOutlet var quizTone2FretFret12ImageView : UIImageView!
    @IBOutlet var quizTone2FretFret13ImageView : UIImageView!
    @IBOutlet var quizTone2FretFret21ImageView : UIImageView!
    @IBOutlet var quizTone2FretFret22ImageView : UIImageView!
    @IBOutlet var quizTone2FretFret23ImageView : UIImageView!
    @IBOutlet var quizTone2FretFret31ImageView : UIImageView!
    @IBOutlet var quizTone2FretFret32ImageView : UIImageView!
    @IBOutlet var quizTone2FretFret33ImageView : UIImageView!
    @IBOutlet var quizTone2FretFret41ImageView : UIImageView!
    @IBOutlet var quizTone2FretFret42ImageView : UIImageView!
    @IBOutlet var quizTone2FretFret43ImageView : UIImageView!
    @IBOutlet var quizTone2FretFret51ImageView : UIImageView!
    @IBOutlet var quizTone2FretFret52ImageView : UIImageView!
    @IBOutlet var quizTone2FretFret53ImageView : UIImageView!
    @IBOutlet var quizTone2FretFret61ImageView : UIImageView!
    @IBOutlet var quizTone2FretFret62ImageView : UIImageView!
    @IBOutlet var quizTone2FretFret63ImageView : UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

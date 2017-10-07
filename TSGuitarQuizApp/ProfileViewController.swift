//
//  ScoreViewController.swift
//  TSGuitarQuizApp
//
//  Created by nttr on 2017/07/20.
//  Copyright © 2017年 nttr. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    // ランク画像
    @IBOutlet var profileRankImageView : UIImageView!
    
    // ランク名
    @IBOutlet var profileRankNameLavel : UILabel!
    
    // ランク説明
    @IBOutlet var profileRankExplanation : UITextView!
    
    // 過去の戦績ビュー
    @IBOutlet var profileQuizResultsTextView : UITextView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 各データを初期化する
        initProfileView()
        
        // 戦績ビューを初期化する
        initQuizResults()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // プロフィール欄を初期化する
    func initProfileView () {
        
        let rankId : Int = KB.getUserRank()
        
        self.profileRankImageView.image = UIImage(named : KB.PROFILE_RANKS_ICON_IMAGEPATHES[rankId])
        self.profileRankNameLavel.text = "ランク：" + KB.getUserRankName()
        self.profileRankExplanation.text = KB.getUserRankExplanation()
    }
    
    // 過去の戦績を表示する
    func initQuizResults () {
        
        var tmpText : String = ""
        
        // 過去の戦績を取得する
        var isCleares : [Bool] = KB.getQuizTypesIsCleares()
        var bestScoreRates : [Int] = KB.getQuizTypesBestScoreRates()
        var bestTimeSec : [Int] = KB.getQuizTypesBestTimeSecs()
        var bestDateTime : [String] = KB.getQuizTypesBestDateTimes()
        var numChallenges : [Int] = KB.getQuizTypesNumChalleges()
        
        // 総合評価を計算する
        var numAllChallenges : Int = 0
        for i in 0 ..< isCleares.count {
            
            numAllChallenges += numChallenges[i]
        }
        
        // 総合評価を表示する
        tmpText = tmpText + "総挑戦回数：" + String(numAllChallenges) + "\n\n"
        
        // クイズ別に結果を表示する
        for i in 0 ..< isCleares.count {
            
            // 未挑戦の場合には、何も表示しない
            if(numChallenges[i] == 0){
                
                tmpText = tmpText + "\n\n"
            }
            // 到達した場合には、ベストスコアを表示する
            else {
                
                // タイトルを表示する
                tmpText = tmpText + "■" + KB.QUIZ_TYPES_NAMES[i]
                    + "（挑戦回数　" + String(numChallenges[i]) + ")"
                    + (isCleares[i] ? "　【合格♪】" : "") + " \n"

                tmpText = tmpText + "　★ベストスコア★ <" + String(bestDateTime[i]) + "> \n"
                tmpText = tmpText + "　・得点率　：" + String(bestScoreRates[i]) + "% \n"
                tmpText = tmpText + "　・所要時間：" + String(bestTimeSec[i]) + "秒 \n\n"
            }
        }
        
        profileQuizResultsTextView.text = tmpText
    }
    
    // 確認完了ボタン押下時の動作を定義する
    @IBAction func pushReturnButton () {
        
        self.navigationController?.popToViewController((self.navigationController?.viewControllers[1])!, animated: true)
    }
}

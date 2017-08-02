//
//  ResultViewController.swift
//  TSGuitarQuizApp
//
//  Created by nttr on 2017/07/20.
//  Copyright © 2017年 nttr. All rights reserved.
//

import UIKit

class QuizResultViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // クイズ種別のテキストビュー
    @IBOutlet var quizResultQuizTypeLabel : UILabel!
    
    // 合否イメージビュー
    @IBOutlet var quizResultImageView : UIImageView!
    
    // 合否テキスト
    @IBOutlet var quizResultTextView : UITextView!
    
    // 各問題用の表示テーブルビュー
    @IBOutlet var quizResultQuizTableView : UITableView!
    
    // 選択肢ラベル
    @IBOutlet var quizResultChoiceTitleLabel : UILabel!
    
    
    // 選択されたクイズのレベルID
    var quizLevelId : Int = 0
    
    // 選択されたクイズ種別ID
    var quizTypeId : Int = 0
    
    // ユーザが実際に選択した選択肢ID
    var selectedChoiceIds : [Int] = []
    
    // 各問題の弦ID、フレットID、音階値
    // (stringIdFretIdTones[i(問目)][j(番目の選択肢)])
    var stringIdFretIdTones : [[[Int]]] = []
    
    // 各問題の選択肢ID
    // (choiceIds[i][j] = "stringIdFretIdTones[i(問目)][j(番目の選択肢)]の実際の表示番目")
    var choiceIds : [[Int]] = []
    
    // 各問題のユーザの正誤
    var quizCorrectivities : [Bool] = []
    
    // ユーザの回答所要時間
    var quizUserTime : Double = 0.0
    
    // ユーザの成績
    var passingScoreRate : Int = 0
    var greatScoreRate : Int = 0
    var passingTimeSec : Int = 0
    var greatTimeSec : Int = 0
    var userScore : Int = 0
    var userScoreRate : Int = 0
    var successScoreRateFlag : Bool = false
    var greatScoreRateFlag : Bool = false
    var successTimeFlag : Bool = false
    var greatTimeFlag : Bool = false
    var successFlag : Bool = false
    
    // ユーザの前回の成績
    var preSuccessFlag : Bool = false
    var preBestScoreRate : Int = 0
    var preBestTimeSec : Int = 0
    var preBestDateTime : String = ""
    var preNumChallenge : Int = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // ユーザの成績を分析する
        initUserScores()
        
        // テーブルビューを初期化
        quizResultQuizTableView.dataSource = self
        quizResultQuizTableView.delegate = self
        
        let nib = UINib(nibName: KB.QUIZ_RESULT_TABLE_NIB_NAME, bundle: Bundle.main)
        quizResultQuizTableView.register(nib, forCellReuseIdentifier: KB.QUIZ_RESULT_FOR_CELL_REUSE_IDENTIFIER)
        quizResultQuizTableView.tableFooterView = UIView()
        
        // テーブル以外のビューを初期化する
        let resultImagePath = successFlag ? KB.QUIZ_RESULT_IMAGEPATH_SUCCESS : KB.QUIZ_RESULT_IMAGEPATH_FAILURE
        self.quizResultImageView.image = UIImage(named : resultImagePath)
        self.quizResultTextView.text = getResultComment()
        self.quizResultQuizTypeLabel.text = KB.QUIZ_TYPES_NAMES[quizTypeId]
        self.quizResultChoiceTitleLabel.text = "♪回答一覧♪ (" + String(quizCorrectivities.count) + "問)"
        
        // ユーザの成績を保存する
        saveQuizScore()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return stringIdFretIdTones.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tmpCell = tableView.dequeueReusableCell(withIdentifier: KB.QUIZ_RESULT_FOR_CELL_REUSE_IDENTIFIER) as! QuizResultTableViewCell
        
        // 選択肢の表示順番を求める
        var tmpIds : [Int] = []
        for i in 0 ..< choiceIds[indexPath.row].count {
            
            var tmpId : Int = 0
            for j in 0 ..< choiceIds[indexPath.row].count {
                
                if(choiceIds[indexPath.row][j] == i) {
                    
                    tmpId = j
                    break
                }
            }
            tmpIds.append(tmpId)
        }
        var tmpText : String = "■" + String(indexPath.row + 1) + "問目"
        tmpText = tmpText + (quizCorrectivities[indexPath.row] ? "【正解】：\n" : "【不正解】：\n")
        
        // セルにパーツをセットする
        switch KB.getQuizVersionIdFromQuizTypeId(quizTypeId: quizTypeId) {
            
        case KB.QUIZ_VERSIONS_ID_FRET2TONE :
            
            // 選択肢一覧を取得する
            let currentStringIdFretIdTones = stringIdFretIdTones[indexPath.row]
            
            // 問題文を記載する
            tmpText = tmpText + KB.MUSIC_GUITAR_STRINGS_NAMES[currentStringIdFretIdTones[0][0]]
                + "弦"
            tmpText = tmpText + String(currentStringIdFretIdTones[0][1]) + "フレット"
                + (currentStringIdFretIdTones[0][1] == 0 ? "(開放)" : "")
                + "の音は何でしょう？"

            
            // 選択肢を記載する
            for i in 0 ..< currentStringIdFretIdTones.count {

                tmpText = tmpText + "\n"
                
                // 正解の選択肢で、ユーザも選んでいる場合
               if(tmpIds[i] == 0 && i == selectedChoiceIds[indexPath.row]){
                    
                    tmpText = tmpText + "◎"
                }
                // 正解の選択肢で、ユーザが選択していない場合
                else if(tmpIds[i] == 0 && i != selectedChoiceIds[indexPath.row]){
                    
                    tmpText = tmpText + "○"
                }
                // 不正解の選択肢で、ユーザが選択していない場合
                else if(tmpIds[i] != 0 && i == selectedChoiceIds[indexPath.row]){
                    
                    tmpText = tmpText + "✖︎"
                }
                // 不正解の選択肢で、ユーザも未選択の場合
                else {
                    
                    tmpText = tmpText + "　"
                }
                
                // 選択肢の回答を記載する
                tmpText = tmpText + String(i + 1) + "．"
                tmpText = tmpText + KB.getToneName(tone: currentStringIdFretIdTones[tmpIds[i]][2], accidentalId: KB.getMusicNoteAccidentalId())
                
                // 正解・不正解に応じて背景色を変更する
                tmpCell.backgroundColor = (quizCorrectivities[indexPath.row] ?  UIColor.lightGray : UIColor.white)
                tmpCell.quizTextView.textColor = (quizCorrectivities[indexPath.row] ? UIColor.black : UIColor.red)
            }

        case KB.QUIZ_VERSIONS_ID_TONE2FRET :
            
            // 選択肢一覧を取得する
            let currentStringIdFretIdTonesTone2Fret = stringIdFretIdTones[indexPath.row]
            
            // 問題文を記載する
            tmpText = tmpText + KB.getToneName(tone: currentStringIdFretIdTonesTone2Fret[0][2], accidentalId: KB.getMusicNoteAccidentalId()) + " は何弦の何フレットでしょう？"
            
            // 選択肢を記載する
            for i in 0 ..< currentStringIdFretIdTonesTone2Fret.count {
                
                tmpText = tmpText + "\n"
                
                // 正解の選択肢で、ユーザも選んでいる場合
                if(tmpIds[i] == 0 && i == selectedChoiceIds[indexPath.row]){
                    
                    tmpText = tmpText + "◎"
                }
                // 正解の選択肢で、ユーザが選択していない場合
                else if(tmpIds[i] == 0 && i != selectedChoiceIds[indexPath.row]){
                    
                    tmpText = tmpText + "○"
                }
                // 不正解の選択肢で、ユーザが選択していない場合
                else if(tmpIds[i] != 0 && i == selectedChoiceIds[indexPath.row]){
                    
                    tmpText = tmpText + "✖︎"
                }
                // 不正解の選択肢で、ユーザも未選択の場合
                else {
                    
                    tmpText = tmpText + "　"
                }
                
                // 選択肢の回答を記載する
                tmpText = tmpText + String(i + 1) + "．"
                tmpText = tmpText
                    + KB.MUSIC_GUITAR_STRINGS_NAMES[currentStringIdFretIdTonesTone2Fret[tmpIds[i]][0]] + "弦の"
                tmpText = tmpText + String(currentStringIdFretIdTonesTone2Fret[tmpIds[i]][1]) + "フレット"
                tmpText = tmpText + (currentStringIdFretIdTonesTone2Fret[tmpIds[i]][1] == 0 ? "(開放)" : "")
                
                // 正解・不正解に応じて背景色を変更する
                tmpCell.backgroundColor = (quizCorrectivities[indexPath.row] ?  UIColor.lightGray : UIColor.white)
                tmpCell.quizTextView.textColor = (quizCorrectivities[indexPath.row] ? UIColor.black : UIColor.red)
            }
            
        default :
            break
        }
        
        tmpCell.quizTextView.text = tmpText
        
        return tmpCell
    }
    
    // セル押下時の動作について定義する
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        let tmpCell = tableView.cellForRow(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // ユーザの成績を解析し、フィールド変数にセットする
    func initUserScores (){
        
        // 基準の正解率・所要時間を取得する
        passingScoreRate = KB.QUIZ_TYPES_PASSING_SCORE_RATE[quizTypeId]
        greatScoreRate = KB.QUIZ_TYPES_GREAT_SCORE_RATE[quizTypeId]
        passingTimeSec = KB.QUIZ_TYPES_PASSING_TIMESEC[quizTypeId]
        greatTimeSec = KB.QUIZ_TYPES_GREAT_TIMESEC[quizTypeId]
        
        // ユーザの正答率を計算する
        userScore = 0
        for i in 0 ..< self.quizCorrectivities.count {
            
            if(quizCorrectivities[i]){
                
                userScore += 1
            }
        }
        userScoreRate = (userScore * 100) / quizCorrectivities.count
        
        // 各種判定を決定する
        successScoreRateFlag = (passingScoreRate <= userScoreRate)
        greatScoreRateFlag = (greatScoreRate <= userScoreRate)
        successTimeFlag = (Int(quizUserTime * 10)) <= passingTimeSec * 10
        greatTimeFlag = (Int(quizUserTime * 10)) <= greatTimeSec * 10
        
        // ユーザの合否を決定する
        successFlag = successScoreRateFlag && successTimeFlag
        
        // 前回のユーザのスコアを取得する
        preSuccessFlag = KB.getQuizTypesIsClear(index: quizTypeId)
        preBestScoreRate = KB.getQuizTypesBestScoreRate(index: quizTypeId)
        preBestTimeSec = KB.getQuizTypesBestTimeSec(index: quizTypeId)
        preBestDateTime = KB.getQuizTypesBestDatetime(index: quizTypeId)
        preNumChallenge = KB.getQuizTypesNumChallege(index: quizTypeId)
    }
    
    
    // 合否の講評コメントを作成する
    // @return 講評コメント
    func getResultComment () -> String {
        
        var tmpComment : String = ""
        
        // 正答率が非常に良い場合
        if(greatScoreRateFlag){
            
            // 所要時間が非常に短い場合
            if(greatTimeFlag) {
                
                tmpComment = "ミスも悩む時間も少なく、文句無しの合格です！\n実際に弾いて更なる精進を♪\n"
            }
            // 所要時間が合格圏内の場合
            else if(successTimeFlag) {
                
                tmpComment = "合格おめでとうございます！！\n素晴らしい正解率ですね♪\n"
            }
            // 所要時間が合格圏外の場合
            else {
                
                tmpComment = "残念。正解率は申し分ないのですが…。\n徐々に回答時間を縮めましょう。\n"
            }
        }
        // 正答率が合格圏内の場合
        else if(successScoreRateFlag) {
            
            // 所要時間が非常に短い場合
            if(greatTimeFlag) {
                
                tmpComment = "リアクションタイムが素晴らしいです！\n祝・合格！その調子です♪\n"
            }
            // 所要時間が合格圏内の場合
            else if(successTimeFlag) {
                
                tmpComment = "合格です！！おめでとうございます。\nクイズへの回答お疲れ様でした♪\n"
            }
            // 所要時間が合格圏外の場合
            else {
                
                tmpComment = "今の正答率を維持してより早く回答を！\n次回の挑戦に期待してます。\n"
            }
        }
        // 正答率が合格圏外の場合
        else {
            
            // 所要時間が非常に短い場合
            if(greatTimeFlag) {
                
                tmpComment = "もう少し落ち着いて回答しましょう。\n一問ずつしっかり丁寧に。\n"
            }
            // 所要時間が合格圏内の場合
            else if(successTimeFlag) {
                
                tmpComment = "回答ペースを維持して正答率UPを。\n次回のチャレンジをお待ちしてます。\n"
            }
            // 所要時間が合格圏外の場合
            else {
                
                tmpComment = "一旦、各フレットの音を見直してみると\n良いかもしれません。ファイトです。\n"
            }
        }
        
        tmpComment = tmpComment + "正解：" + String(userScore)
                + " / " + String(quizCorrectivities.count)
                + "問 (" + String(userScoreRate) + "%) [目標："
                + String(passingScoreRate) + "%] \n"
                + "所要時間：" + String(((Int)(quizUserTime)))
                + "秒 [目標：" + String(passingTimeSec) + "秒]"
        
        return tmpComment
    }
    
    // ベストスコアへの保存是非を取得する
    // @return 保存是非
    func isSave2BestScores () -> Bool {
        
        var tmpFlag : Bool = false
        
        // 前回合格している場合
        if(preSuccessFlag) {
            
            // 得点率が上回っていれば、記録する
            if(userScoreRate > preBestScoreRate) {
                
                tmpFlag = true
            }
            // 得点率が同じ場合、所要時間が上回っていれば記録する
            else if(userScoreRate == preBestScoreRate && ((Int)(quizUserTime)) < preBestTimeSec){
                
                tmpFlag = true
            }
        }
        // 前回不合格の場合
        else {
            
            // 合格であれば、記録する
            if(successFlag) {
                
                tmpFlag = true
            }
            // 得点率が上回っていれば、記録する
            else if(userScoreRate > preBestScoreRate) {
                
                tmpFlag = true
            }
            // 得点率が同じ場合、所要時間が上回っていれば記録する
            else if(userScoreRate == preBestScoreRate && ((Int)(quizUserTime)) < preBestTimeSec) {
                
                tmpFlag = true
            }
        }
        return tmpFlag
    }
    
    // スコアを保存する
    func saveQuizScore () {
        
        // 必要に応じて、ベストスコアを保存する
        if(isSave2BestScores()) {
            
            KB.saveQuizTypesIsClear(index: quizTypeId, isClear: successFlag || preSuccessFlag)
            KB.saveQuizTypesBestScoreRate(index: quizTypeId, rate: userScoreRate)
            KB.saveQuizTypesBestTimeSec(index: quizTypeId, timeSec: ((Int)(quizUserTime)))
            
            // 現在日時を保存する
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd' 'HH:mm:ss"
            let now = Date()
            KB.saveQuizTypesBestDateTime(index: quizTypeId, dateTime: formatter.string(from : now ))
        }
        
        // 挑戦回数を更新する
        KB.saveQuizTypesNumChallenge(index: quizTypeId, numChallenge: preNumChallenge + 1)
    }
    
    // メニューに戻るボタンの押下時
    @IBAction func pushBack2MenuButton () {
        
        self.navigationController?.popToViewController((self.navigationController?.viewControllers[1])!, animated: true)
    }
    
    // クイズ種別選択画面に戻る
    @IBAction func pushBack2QuizTypeSelectButton () {
        
        self.navigationController?.popToViewController((self.navigationController?.viewControllers[2])!, animated: true)
    }

}

//
//  Fret2ToneViewController.swift
//  TSGuitarQuizApp
//
//  Created by nttr on 2017/07/20.
//  Copyright © 2017年 nttr. All rights reserved.
//

import UIKit

class QuizFret2ToneViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // 現在の問題/問題数のラベル
    @IBOutlet var quizFret2ToneNumQuizLabel : UILabel!
    
    // ラップタイムの表示ラベル
    @IBOutlet var quizFret2ToneLapTimeSecLabel : UILabel!
    
    // 問題文テキストビュー
    @IBOutlet var quizFret2ToneQuizTextView : UITextView!
    
    // フレットIDの表示ラベル
    @IBOutlet var quizFret2ToneFretId1Label : UILabel!
    @IBOutlet var quizFret2ToneFretId2Label : UILabel!
    @IBOutlet var quizFret2ToneFretId3Label : UILabel!
    
    // 弦IDの表示ラベル
    @IBOutlet var quizFret2ToneStringId1Label : UILabel!
    @IBOutlet var quizFret2ToneStringId2Label : UILabel!
    @IBOutlet var quizFret2ToneStringId3Label : UILabel!
    @IBOutlet var quizFret2ToneStringId4Label : UILabel!
    @IBOutlet var quizFret2ToneStringId5Label : UILabel!
    @IBOutlet var quizFret2ToneStringId6Label : UILabel!
    
    // 各弦IDの解放表示ラベル
    @IBOutlet var quizFret2ToneOpenStringId1Label : UILabel!
    @IBOutlet var quizFret2ToneOpenStringId2Label : UILabel!
    @IBOutlet var quizFret2ToneOpenStringId3Label : UILabel!
    @IBOutlet var quizFret2ToneOpenStringId4Label : UILabel!
    @IBOutlet var quizFret2ToneOpenStringId5Label : UILabel!
    @IBOutlet var quizFret2ToneOpenStringId6Label : UILabel!
    
    // 弦のアイコン表示ラベル
    @IBOutlet var quizFret2ToneFret11ImageView : UIImageView!
    @IBOutlet var quizFret2ToneFret12ImageView : UIImageView!
    @IBOutlet var quizFret2ToneFret13ImageView : UIImageView!
    @IBOutlet var quizFret2ToneFret21ImageView : UIImageView!
    @IBOutlet var quizFret2ToneFret22ImageView : UIImageView!
    @IBOutlet var quizFret2ToneFret23ImageView : UIImageView!
    @IBOutlet var quizFret2ToneFret31ImageView : UIImageView!
    @IBOutlet var quizFret2ToneFret32ImageView : UIImageView!
    @IBOutlet var quizFret2ToneFret33ImageView : UIImageView!
    @IBOutlet var quizFret2ToneFret41ImageView : UIImageView!
    @IBOutlet var quizFret2ToneFret42ImageView : UIImageView!
    @IBOutlet var quizFret2ToneFret43ImageView : UIImageView!
    @IBOutlet var quizFret2ToneFret51ImageView : UIImageView!
    @IBOutlet var quizFret2ToneFret52ImageView : UIImageView!
    @IBOutlet var quizFret2ToneFret53ImageView : UIImageView!
    @IBOutlet var quizFret2ToneFret61ImageView : UIImageView!
    @IBOutlet var quizFret2ToneFret62ImageView : UIImageView!
    @IBOutlet var quizFret2ToneFret63ImageView : UIImageView!
    
    // 選択肢を表示するテーブルビュー
    @IBOutlet var quizFret2ToneTableView : UITableView!
    
    // 選択肢タイトルビュー
    @IBOutlet var quizFret2ToneChoiceTitleLabel : UILabel!
    
    // クイズ種別タイトルラベル
    @IBOutlet var quizFret2ToneQuizTypeNameLabel : UILabel!
    
    
    // 選択されたクイズレベルID
    var quizLevelId : Int = 0
    
    // 選択されたクイズ種別ID
    var quizTypeId : Int = 0
    
    // 選択肢のチェック有無
    var isCheckes : [Bool] = []
    
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
    
    // タイマに関する変数
    var timer = Timer()
    var startTime : TimeInterval = 0
    var elapsedTime : Double = 0.0
    var time : Double = 0.0
    var quizUserTime : Double = 0.0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // フィールド変数を初期化
        isCheckes.removeAll()
        for _ in 0 ..< KB.QUIZ_TYPES_NUMCHOICES.count {
            
            isCheckes.append(false)
        }
        self.quizTypeId = KB.getQuizTypeIdFromQuizLevelIdQuizVersionId(quizLevelId: self.quizLevelId, quizVersionId: KB.QUIZ_VERSIONS_ID_FRET2TONE)
        
        // クイズ種別名のラベルをセットする
        quizFret2ToneQuizTypeNameLabel.text = KB.QUIZ_TYPES_NAMES[quizTypeId]
        
        // 最初の問題を取得する
        addNextQuiz()

        // テーブルビューを初期化
        quizFret2ToneTableView.dataSource = self
        quizFret2ToneTableView.delegate = self
        quizFret2ToneTableView.tableFooterView = UIView()
        
        let nib = UINib(nibName: KB.QUIZ_FRET2TONE_TABLE_NIB_NAME, bundle: Bundle.main)
        quizFret2ToneTableView.register(nib, forCellReuseIdentifier: KB.QUIZ_FRET2TONE_FOR_CELL_REUSE_IDENTIFIER)
        
        // タイマーの初期設定を行う
        startTime = Date().timeIntervalSince1970
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.updateTimer), userInfo: nil, repeats: true)
        
        // 選択肢ラベルを表示する
        quizFret2ToneChoiceTitleLabel.text = "♪選択肢♪ (" + String(KB.QUIZ_TYPES_NUMCHOICES[quizTypeId]) + "個から1つ選択)"
        
        // テーブル以外の画面を初期化
        initQuizView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        // 結果画面から戻るボタンが押された場合には、ゲーム選択画面を戻る
        if(self.selectedChoiceIds.count >= KB.QUIZ_TYPES_NUMQUIZ[quizTypeId]){
            
            self.navigationController?.popToViewController((self.navigationController?.viewControllers[2])!, animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // テーブルの表示個数を定義する
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return KB.QUIZ_TYPES_NUMCHOICES[self.quizTypeId]
    }
    
    // セルの表示内容を定義する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // セルを取得する
        let tmpCell = tableView.dequeueReusableCell(withIdentifier: KB.QUIZ_FRET2TONE_FOR_CELL_REUSE_IDENTIFIER) as! QuizFret2ToneTableViewCell
        
        // 背景色を元に戻す
        tmpCell.backgroundColor = UIColor.white
        
        // セルのパーツにセットする
        tmpCell.quizFret2ToneAnswerLabel.text = getChoiceText(numOfRows: indexPath.row)

        return tmpCell
    }
    
    // セル押下時の動作について定義する
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let tmpCell = tableView.cellForRow(at: indexPath)
        
        if(self.isCheckes[indexPath.row]){
        
            isCheckes[indexPath.row] = false
            tmpCell?.backgroundColor = UIColor.white
        }
        else{
        
            isCheckes[indexPath.row] = true
            tmpCell?.backgroundColor = UIColor.lightGray
        }
//        tmpCell?.isSelected = false
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // セル押下時の画面間の値渡しについて定義する
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let quizResultViewController = segue.destination as! QuizResultViewController
    
        quizResultViewController.quizLevelId = quizLevelId
        quizResultViewController.quizTypeId = quizTypeId
        quizResultViewController.selectedChoiceIds = selectedChoiceIds
        quizResultViewController.stringIdFretIdTones = stringIdFretIdTones
        quizResultViewController.choiceIds = choiceIds
        quizResultViewController.quizCorrectivities = quizCorrectivities
        quizResultViewController.quizUserTime = quizUserTime
    }

    
    // 次の問題を取得し、フィールド変数に格納する
    func addNextQuiz () {
        
        // これまでの問題の正解選択肢（弦ID、フレットID、音階値の組み合わせ）を取得する
        var preStringIdFretIdTones : [[Int]] = []
        for i in 0 ..< self.stringIdFretIdTones.count {
            
            preStringIdFretIdTones.append(self.stringIdFretIdTones[i][0])
        }
        
        // 新しい問題の選択肢（弦ID、フレットID、音階値の組み合わせ）を取得する
        let newStringIdFretIdTones = KB.getStringIdFretIdTonesForQuiz(quizTypeId: quizTypeId, preStringIdFretIdTones: preStringIdFretIdTones)
        
        // 選択肢の表示順番を決定する
        let numChoices = KB.QUIZ_TYPES_NUMCHOICES[self.quizTypeId]
        let newChoiceIds = KB.getRandomValues(minValue: 0, maxValue: numChoices - 1, numValue: numChoices)
        
        // フィールド変数に格納する
        self.stringIdFretIdTones.append(newStringIdFretIdTones)
        self.choiceIds.append(newChoiceIds)
        
        print(KB.getToneName(tone: stringIdFretIdTones[stringIdFretIdTones.count - 1][0][2], accidentalId: KB.getMusicNoteAccidentalId()))
    }
    
    // 最新の問題文のテキストを取得する
    // @return 問題文
    func getQuizText () -> String {
        
        // 現在のクイズの正解選択肢の弦ID、フレットID、音階値を取得する
        let currentStringIdFretIdTone = self.stringIdFretIdTones[self.stringIdFretIdTones.count - 1][0]

        // フレットについての文字列を作成する
        var tmpFretStr : String = String(currentStringIdFretIdTone[1]) + "フレット"
        if(currentStringIdFretIdTone[1] == 0){
            
            tmpFretStr = tmpFretStr + "(開放)"
        }
        
        return KB.MUSIC_GUITAR_STRINGS_NAMES[currentStringIdFretIdTone[0]] + "弦の"
            + tmpFretStr + "の音は何でしょう？"
    }
    
    // 選択肢のテキストを取得する
    // @param numOfRows セルの表示番目
    // @return 表示テキスト
    func getChoiceText (numOfRows : Int) -> String {
        
        // 現在のクイズの選択肢の弦ID、フレットID、音階値を取得する
        let currentStringIdFretIdTone = self.stringIdFretIdTones[self.stringIdFretIdTones.count - 1]
        
        // 現在のクイズの選択肢の表示順番を取得する
        let currentChoiceIds : [Int] = self.choiceIds[self.choiceIds.count - 1]

        var tmpId : Int = 0
        for i in 0 ..< currentChoiceIds.count {
            
            if(currentChoiceIds[i] == numOfRows){
                
                tmpId = i
                break
            }
        }

        return String(1 + numOfRows) + "．" + KB.getToneName(tone: currentStringIdFretIdTone[tmpId][2], accidentalId: KB.getMusicNoteAccidentalId())
        
//        return KB.getToneName(tone: currentStringIdFretIdTone[currentChoiceIds[numOfRows]][2], accidentalId: KB.getMusicNoteAccidentalId())
    }
    
    // フレットイメージをセットする
    func initFletView () {
        
        // 現在のクイズの正解選択肢の弦ID、フレットID、音階値を取得する
        let currentStringIdFretIdTone = self.stringIdFretIdTones[self.stringIdFretIdTones.count - 1][0]
        
        // フレット番号のラベルをセットする
        var midFretId : Int = currentStringIdFretIdTone[1]
        if(midFretId <= 1){

            midFretId = 2
        }
        else if(midFretId == KB.MUSIC_GUITAR_STRINGS_DEFAULT_NUM_FRETS[quizTypeId]){
            
            midFretId -= 1
        }
        quizFret2ToneFretId1Label.text = String(midFretId - 1)
        quizFret2ToneFretId2Label.text = String(midFretId)
        quizFret2ToneFretId3Label.text = String(midFretId + 1)
        
        // 使用の有無によって、弦番号のラベルに色付けする
        let stringId = currentStringIdFretIdTone[0]
        quizFret2ToneStringId1Label.textColor = (stringId == 0) ? UIColor.red : UIColor.black
        quizFret2ToneStringId2Label.textColor = (stringId == 1) ? UIColor.red : UIColor.black
        quizFret2ToneStringId3Label.textColor = (stringId == 2) ? UIColor.red : UIColor.black
        quizFret2ToneStringId4Label.textColor = (stringId == 3) ? UIColor.red : UIColor.black
        quizFret2ToneStringId5Label.textColor = (stringId == 4) ? UIColor.red : UIColor.black
        quizFret2ToneStringId6Label.textColor = (stringId == 5) ? UIColor.red : UIColor.black
        quizFret2ToneOpenStringId1Label.textColor = (stringId == 0) ? UIColor.red : UIColor.black
        quizFret2ToneOpenStringId2Label.textColor = (stringId == 1) ? UIColor.red : UIColor.black
        quizFret2ToneOpenStringId3Label.textColor = (stringId == 2) ? UIColor.red : UIColor.black
        quizFret2ToneOpenStringId4Label.textColor = (stringId == 3) ? UIColor.red : UIColor.black
        quizFret2ToneOpenStringId5Label.textColor = (stringId == 4) ? UIColor.red : UIColor.black
        quizFret2ToneOpenStringId6Label.textColor = (stringId == 5) ? UIColor.red : UIColor.black
        
        // 解放の有無によって、開放ラベルの内容をセットする
        let fretId : Int = currentStringIdFretIdTone[1]
        quizFret2ToneOpenStringId1Label.text = (stringId == 0 && fretId == 0) ? "開放" : ""
        quizFret2ToneOpenStringId2Label.text = (stringId == 1 && fretId == 0) ? "開放" : ""
        quizFret2ToneOpenStringId3Label.text = (stringId == 2 && fretId == 0) ? "開放" : ""
        quizFret2ToneOpenStringId4Label.text = (stringId == 3 && fretId == 0) ? "開放" : ""
        quizFret2ToneOpenStringId5Label.text = (stringId == 4 && fretId == 0) ? "開放" : ""
        quizFret2ToneOpenStringId6Label.text = (stringId == 5 && fretId == 0) ? "開放" : ""
        
        // 各フレットに画像をセットする
        quizFret2ToneFret11ImageView.image = (stringId == 0 && fretId - (midFretId - 2) == 1) ? UIImage(named : KB.MUSIC_GUITAR_FRET_PRESSING_IMAGEPATH) : UIImage(named: KB.MUSIC_GUITAR_FRET_NOT_PRESSING_IMAGEPATH)
        quizFret2ToneFret12ImageView.image = (stringId == 0 && fretId - (midFretId - 2) == 2) ? UIImage(named : KB.MUSIC_GUITAR_FRET_PRESSING_IMAGEPATH) : UIImage(named: KB.MUSIC_GUITAR_FRET_NOT_PRESSING_IMAGEPATH)
        quizFret2ToneFret13ImageView.image = (stringId == 0 && fretId - (midFretId - 2) == 3) ? UIImage(named : KB.MUSIC_GUITAR_FRET_PRESSING_IMAGEPATH) : UIImage(named: KB.MUSIC_GUITAR_FRET_NOT_PRESSING_IMAGEPATH)
        quizFret2ToneFret21ImageView.image = (stringId == 1 && fretId - (midFretId - 2) == 1) ? UIImage(named : KB.MUSIC_GUITAR_FRET_PRESSING_IMAGEPATH) : UIImage(named: KB.MUSIC_GUITAR_FRET_NOT_PRESSING_IMAGEPATH)
        quizFret2ToneFret22ImageView.image = (stringId == 1 && fretId - (midFretId - 2) == 2) ? UIImage(named : KB.MUSIC_GUITAR_FRET_PRESSING_IMAGEPATH) : UIImage(named: KB.MUSIC_GUITAR_FRET_NOT_PRESSING_IMAGEPATH)
        quizFret2ToneFret23ImageView.image = (stringId == 1 && fretId - (midFretId - 2) == 3) ? UIImage(named : KB.MUSIC_GUITAR_FRET_PRESSING_IMAGEPATH) : UIImage(named: KB.MUSIC_GUITAR_FRET_NOT_PRESSING_IMAGEPATH)
        quizFret2ToneFret31ImageView.image = (stringId == 2 && fretId - (midFretId - 2) == 1) ? UIImage(named : KB.MUSIC_GUITAR_FRET_PRESSING_IMAGEPATH) : UIImage(named: KB.MUSIC_GUITAR_FRET_NOT_PRESSING_IMAGEPATH)
        quizFret2ToneFret32ImageView.image = (stringId == 2 && fretId - (midFretId - 2) == 2) ? UIImage(named : KB.MUSIC_GUITAR_FRET_PRESSING_IMAGEPATH) : UIImage(named: KB.MUSIC_GUITAR_FRET_NOT_PRESSING_IMAGEPATH)
        quizFret2ToneFret33ImageView.image = (stringId == 2 && fretId - (midFretId - 2) == 3) ? UIImage(named : KB.MUSIC_GUITAR_FRET_PRESSING_IMAGEPATH) : UIImage(named: KB.MUSIC_GUITAR_FRET_NOT_PRESSING_IMAGEPATH)
        quizFret2ToneFret41ImageView.image = (stringId == 3 && fretId - (midFretId - 2) == 1) ? UIImage(named : KB.MUSIC_GUITAR_FRET_PRESSING_IMAGEPATH) : UIImage(named: KB.MUSIC_GUITAR_FRET_NOT_PRESSING_IMAGEPATH)
        quizFret2ToneFret42ImageView.image = (stringId == 3 && fretId - (midFretId - 2) == 2) ? UIImage(named : KB.MUSIC_GUITAR_FRET_PRESSING_IMAGEPATH) : UIImage(named: KB.MUSIC_GUITAR_FRET_NOT_PRESSING_IMAGEPATH)
        quizFret2ToneFret43ImageView.image = (stringId == 3 && fretId - (midFretId - 2) == 3) ? UIImage(named : KB.MUSIC_GUITAR_FRET_PRESSING_IMAGEPATH) : UIImage(named: KB.MUSIC_GUITAR_FRET_NOT_PRESSING_IMAGEPATH)
        quizFret2ToneFret51ImageView.image = (stringId == 4 && fretId - (midFretId - 2) == 1) ? UIImage(named : KB.MUSIC_GUITAR_FRET_PRESSING_IMAGEPATH) : UIImage(named: KB.MUSIC_GUITAR_FRET_NOT_PRESSING_IMAGEPATH)
        quizFret2ToneFret52ImageView.image = (stringId == 4 && fretId - (midFretId - 2) == 2) ? UIImage(named : KB.MUSIC_GUITAR_FRET_PRESSING_IMAGEPATH) : UIImage(named: KB.MUSIC_GUITAR_FRET_NOT_PRESSING_IMAGEPATH)
        quizFret2ToneFret53ImageView.image = (stringId == 4 && fretId - (midFretId - 2) == 3) ? UIImage(named : KB.MUSIC_GUITAR_FRET_PRESSING_IMAGEPATH) : UIImage(named: KB.MUSIC_GUITAR_FRET_NOT_PRESSING_IMAGEPATH)
        quizFret2ToneFret61ImageView.image = (stringId == 5 && fretId - (midFretId - 2) == 1) ? UIImage(named : KB.MUSIC_GUITAR_FRET_PRESSING_IMAGEPATH) : UIImage(named: KB.MUSIC_GUITAR_FRET_NOT_PRESSING_IMAGEPATH)
        quizFret2ToneFret62ImageView.image = (stringId == 5 && fretId - (midFretId - 2) == 2) ? UIImage(named : KB.MUSIC_GUITAR_FRET_PRESSING_IMAGEPATH) : UIImage(named: KB.MUSIC_GUITAR_FRET_NOT_PRESSING_IMAGEPATH)
        quizFret2ToneFret63ImageView.image = (stringId == 5 && fretId - (midFretId - 2) == 3) ? UIImage(named : KB.MUSIC_GUITAR_FRET_PRESSING_IMAGEPATH) : UIImage(named: KB.MUSIC_GUITAR_FRET_NOT_PRESSING_IMAGEPATH)
        
        
//        print("stringId = " + String(stringId) + ", fretId = " + String(fretId) + "(midFretId = " + String(midFretId) + "), tone = " + String(currentStringIdFretIdTone[2]))
        
    }
    
    // 問題部分のビューをセットする
    func initQuizView () {

        // 回答数の欄を更新する
        quizFret2ToneNumQuizLabel.text = String(selectedChoiceIds.count + 1) + "問目 / 全" + String(KB.QUIZ_TYPES_NUMQUIZ[quizTypeId]) + "問"
        
        // 問題欄を更新する
        quizFret2ToneQuizTextView.text = getQuizText()
        
        // フレットのイメージをセットする
        initFletView()
    }
    
    
    // ボタン押下時の処理
    @IBAction func pushButton () {
        
        // 回答数や回答IDを調べる
        var tmpCount : Int = 0
        var tmpChoiceId : Int = 0
        for i in 0 ..< isCheckes.count {
            
            if(isCheckes[i]){
                
                tmpCount += 1
                tmpChoiceId = i
            }
        }
        
        // 回答数が1つ以外の場合には、アラートを出す
        if(tmpCount != 1) {
            
            let alert = UIAlertController(title: "選択ミス", message: "1つだけ選択してください", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                alert.dismiss(animated: true, completion: nil)
            })
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
                
            return
        }
        
        // 回答を保存する
        self.selectedChoiceIds.append(tmpChoiceId)
        
        // 回答の正誤を判定し、フィールド変数に格納する
        var tmpCorrectivity : Bool = false
        if(tmpChoiceId == self.choiceIds[self.selectedChoiceIds.count - 1][0]){
            
            tmpCorrectivity = true
        }
        self.quizCorrectivities.append(tmpCorrectivity)
        
        // 全ての問題をこなした場合、結果画面に遷移する
        if(selectedChoiceIds.count >= KB.QUIZ_TYPES_NUMQUIZ[quizTypeId]){
            
            // 所要時間を取得
            quizUserTime = time
            
            // 処理を記述
            self.performSegue(withIdentifier: KB.QUIZ_FRET2TONE_PEFORM_SEGUE_IDENTIFIER_CELL_TORESULT, sender: nil)
            return
        }
        
        // 次の問題を取得する
        addNextQuiz()
        
        // クイズ周りのビューを更新
        initQuizView()
        
        // フィールド変数を初期化する
        isCheckes.removeAll()
        for _ in 0 ..< KB.QUIZ_TYPES_NUMCHOICES.count {
            
            isCheckes.append(false)
        }
        
        // テーブルビューを更新
        quizFret2ToneTableView.reloadData()

    }
    
    // タイマーのビューを更新する
    func updateTimer () {
        
        // 経過時間を計算する
        time = Date().timeIntervalSince1970 - startTime + elapsedTime
        
        // 時間を小数点前後で分割
        let sec = Int(time)
        let msec = Int((time - Double(sec)) * 100)
        
        // 「XX:XX.XX」形式でラベルに表示する
        let displayStr = NSString(format: "%02d:%02d.%02d", sec / 60, sec % 60, msec) as String
        quizFret2ToneLapTimeSecLabel.text = displayStr
    }
}

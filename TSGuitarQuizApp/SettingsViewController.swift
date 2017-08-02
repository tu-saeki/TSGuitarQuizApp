//
//  SettingsViewController.swift
//  TSGuitarQuizApp
//
//  Created by nttr on 2017/07/20.
//  Copyright © 2017年 nttr. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    // 調弦用の選択ビュー
    @IBOutlet var settingsStringId1PickerView : UIPickerView!
    @IBOutlet var settingsStringId2PickerView : UIPickerView!
    @IBOutlet var settingsStringId3PickerView : UIPickerView!
    @IBOutlet var settingsStringId4PickerView : UIPickerView!
    @IBOutlet var settingsStringId5PickerView : UIPickerView!
    @IBOutlet var settingsStringId6PickerView : UIPickerView!
    
    // 変音記号選択用のビュー
    @IBOutlet var settingsAccidentalSegmentControl : UISegmentedControl!
    
    // 調弦で選択可能な音階値
    // [[6弦の音階値], [5弦の音階値], ... , [1弦の音階値]]
    var selectableTones : [[Int]] = []
    
    // 調弦で設定された音階値のインデックス
    var selectedToneIds : [Int] = []
    
    // 現在表示するように設定されている変音記号（#または♭）
    var acciedentalId : Int = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 現在の調弦設定状況を取得する
        initSelectableTones()
        
        // 現在表示するように設定されている変音記号を取得する
        acciedentalId = KB.getMusicNoteAccidentalId()
        
        // PickerViewの初期化を行う
        settingsStringId1PickerView.dataSource = self
        settingsStringId2PickerView.dataSource = self
        settingsStringId3PickerView.dataSource = self
        settingsStringId4PickerView.dataSource = self
        settingsStringId5PickerView.dataSource = self
        settingsStringId6PickerView.dataSource = self
        settingsStringId1PickerView.delegate = self
        settingsStringId2PickerView.delegate = self
        settingsStringId3PickerView.delegate = self
        settingsStringId4PickerView.delegate = self
        settingsStringId5PickerView.delegate = self
        settingsStringId6PickerView.delegate = self
        settingsStringId1PickerView.tag = 0
        settingsStringId2PickerView.tag = 1
        settingsStringId3PickerView.tag = 2
        settingsStringId4PickerView.tag = 3
        settingsStringId5PickerView.tag = 4
        settingsStringId6PickerView.tag = 5
        
        // はじめに表示する項目を指定
        settingsStringId1PickerView.selectRow(selectedToneIds[0], inComponent: 0, animated: true)
        settingsStringId2PickerView.selectRow(selectedToneIds[1], inComponent: 0, animated: true)
        settingsStringId3PickerView.selectRow(selectedToneIds[2], inComponent: 0, animated: true)
        settingsStringId4PickerView.selectRow(selectedToneIds[3], inComponent: 0, animated: true)
        settingsStringId5PickerView.selectRow(selectedToneIds[4], inComponent: 0, animated: true)
        settingsStringId6PickerView.selectRow(selectedToneIds[5], inComponent: 0, animated: true)
        
        // segmentedControlのビューを設定する
        settingsAccidentalSegmentControl.setTitle(KB.MUSIC_NOTE_ACCIDENTAL_NAMES[KB.MUSIC_NOTE_ACCIDENTAL_ID_SHARP], forSegmentAt: 0)
        settingsAccidentalSegmentControl.setTitle(KB.MUSIC_NOTE_ACCIDENTAL_NAMES[KB.MUSIC_NOTE_ACCIDENTAL_ID_FLAT], forSegmentAt: 1)
        
        // はじめに表示する項目を設定
        acciedentalId = KB.getMusicNoteAccidentalId()
        settingsAccidentalSegmentControl.selectedSegmentIndex =
            (acciedentalId == KB.MUSIC_NOTE_ACCIDENTAL_ID_FLAT ? 1 : 0)
    }

    // pickerViewで表示する列数を定義する
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // pickerViewで表示する行数を定義する
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return selectableTones[pickerView.tag].count
    }
    
    // pickerViewで表示する文字列を定義する
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return KB.getToneName(tone: selectableTones[pickerView.tag][row], accidentalId: KB.getMusicNoteAccidentalId())
    }
    
    // pickerViewが選択された時の処理を定義する
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        selectedToneIds[pickerView.tag] = row
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // 初期の調弦に戻すボタンを押下時の処理
    @IBAction func pushResetStringTuningButton () {
        
        settingsStringId1PickerView.selectRow(0, inComponent: 0, animated: true)
        settingsStringId2PickerView.selectRow(0, inComponent: 0, animated: true)
        settingsStringId3PickerView.selectRow(0, inComponent: 0, animated: true)
        settingsStringId4PickerView.selectRow(0, inComponent: 0, animated: true)
        settingsStringId5PickerView.selectRow(0, inComponent: 0, animated: true)
        settingsStringId6PickerView.selectRow(0, inComponent: 0, animated: true)
        
        for i in 0 ..< selectedToneIds.count {
            
            selectedToneIds[i] = 0
        }
    }
    
    // 保存ボタン押下時の処理
    @IBAction func pushSaveButton () {
        
        // 調弦設定を保存する
        for i in 0 ..< KB.MUSIC_GUITAR_STRINGS_NAMES.count {
            
            KB.saveMusicGuitarStringsBaseTone(index: i, tone: selectableTones[i][selectedToneIds[i]])
        }
        
        // 変音記号設定を保存する
        KB.saveMusicNoteAccidentalId(accidentalId: acciedentalId)

        // 元の画面に戻る
        self.navigationController?.popToViewController((self.navigationController?.viewControllers[1])!, animated: true)
    }
    
    // キャンセルボタン押下時の処理
    @IBAction func pushCancelButton () {
        
        self.navigationController?.popToViewController((self.navigationController?.viewControllers[1])!, animated: true)
    }
    
    // PickerViewで選択可能な音階値について初期化する
    func initSelectableTones () {
        
        // 各弦で選択可能な音階値を取得する
        for i in 0 ..< KB.MUSIC_GUITAR_STRINGS_NAMES.count {
            
            // デフォルト設定値から-4まで選択可能とする
            var tmpTones : [Int] = []
            for j in 0 ..< 5 {
                
                tmpTones.append(KB.MUSIC_GUITAR_STRINGS_DEFAULT_BASE_TONES[i] - j)
            }
            self.selectableTones.append(tmpTones)
        }
        
        // 選択対象とする音階値のうち、現在の設定音階値の表示番目を取得する
        for i in 0 ..< KB.MUSIC_GUITAR_STRINGS_NAMES.count {

            // 現在の設定音階値を取得する
            let tmpTargetTone = KB.getMusicGuitarStringsBaseTone(index: i)
            
            // 表示番目を調べる
            var tmpId : Int = 0
            for j in 0 ..< selectableTones[i].count {
                
                if(selectableTones[i][j] == tmpTargetTone){
                    
                    tmpId = j
                    break
                }
            }
            self.selectedToneIds.append(tmpId)
        }
    }
    
    // segmentedControlの押下時の処理
    @IBAction func pushAccidentalSegmentedControl (_ sender : UISegmentedControl) {
        print("selectedSegmentIndex = " + String(sender.selectedSegmentIndex))
        switch(sender.selectedSegmentIndex){
            
        case 0 :
            acciedentalId = KB.MUSIC_NOTE_ACCIDENTAL_ID_SHARP
            
        case 1 :
            acciedentalId = KB.MUSIC_NOTE_ACCIDENTAL_ID_FLAT
            
        default:
            break
        }
    }
    
    // データを全削除ボタンを押下した時の処理
    @IBAction func pushClearDataButton () {
        
        let alert = UIAlertController(title: "データの全削除", message: "これまでのゲームデータ、設定データが初期化されます。よろしいですか？", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "削除", style: .default, handler: { (action) in
            
            // データを全削除する
            KB.clearUserDefaultsData()
            
            alert.dismiss(animated: true, completion: nil)
            
            // トップ画面に戻る
            self.navigationController?.popToViewController((self.navigationController?.viewControllers[0])!, animated: true)
        })
        let ngAction = UIAlertAction(title: "キャンセル", style: .default, handler: { (action) in
            
            alert.dismiss(animated: true, completion: nil)
        })
        alert.addAction(okAction)
        alert.addAction(ngAction)
        self.present(alert, animated: true, completion: nil)
        
        return
    }

}

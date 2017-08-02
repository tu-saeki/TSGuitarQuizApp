//
//  LevelSelectViewController.swift
//  TSGuitarQuizApp
//
//  Created by nttr on 2017/07/20.
//  Copyright © 2017年 nttr. All rights reserved.
//

import UIKit

class QuizTypeSelectViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // メニューテーブルビュー
    @IBOutlet var quizTypeSelectTableView : UITableView!
    
    // ランク画像
    @IBOutlet var quizTypeSelectRankImageView : UIImageView!
    
    // ランク名
    @IBOutlet var quizTypeSelectRankNameLavel : UILabel!
    
    // ランク説明
    @IBOutlet var quizTypeSelectRankExplanation : UITextView!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        quizTypeSelectTableView.dataSource = self
        quizTypeSelectTableView.delegate = self
        quizTypeSelectTableView.tableFooterView = UIView()
        
        let nib = UINib(nibName: KB.QUIZ_TYPE_SELECT_TABLE_NIB_NAME, bundle: Bundle.main)
        quizTypeSelectTableView.register(nib, forCellReuseIdentifier: KB.QUIZ_TYPE_SEELCT_FOR_CELL_REUSE_IDENTIFIER)
    }

    override func viewDidAppear(_ animated: Bool) {
        
        initProfileView()
        quizTypeSelectTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // テーブルの表示個数を定義する
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return KB.QUIZ_TYPES_NAMES.count
    }
    
    // テーブルの表示内容について定義する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // セルを取得する
        let tmpCell = tableView.dequeueReusableCell(withIdentifier: KB.QUIZ_TYPE_SEELCT_FOR_CELL_REUSE_IDENTIFIER) as! QuizTypeSelectTableViewCell
        
        // セルのパーツにセットする
        tmpCell.quizTypeSelectIcon.image = UIImage(named : KB.QUIZ_TYPES_IMAGEPATHES[indexPath.row])
        tmpCell.quizTypeSelectTitleLabel.text = KB.QUIZ_TYPES_NAMES[indexPath.row]
        tmpCell.quizTypeSelectExplanationTextView.text = KB.QUIZ_TYPE_SELECT_TITLE_EXPLANATIONS[indexPath.row]
        
        // 挑戦可能有無により、セルの状態を変更する
        let isChallengable = KB.getQuizTypesIsChallengable(index: indexPath.row)
        if(isChallengable){
            
            tmpCell.isUserInteractionEnabled = true
            tmpCell.quizTypeSelectIcon.isHidden = false
            tmpCell.quizTypeSelectTitleLabel.textColor = UIColor.black
            tmpCell.quizTypeSelectExplanationTextView.textColor = UIColor.black
        }
        else {
            
            tmpCell.isUserInteractionEnabled = false
            tmpCell.quizTypeSelectIcon.isHidden = true
            tmpCell.quizTypeSelectTitleLabel.textColor = UIColor.lightGray
            tmpCell.quizTypeSelectExplanationTextView.textColor = UIColor.lightGray
        }
        return tmpCell
    }
    
    // セル押下時の画面遷移について定義する
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let versionId = KB.getQuizVersionIdFromQuizTypeId(quizTypeId: indexPath.row)
        switch versionId {
        
        case KB.QUIZ_VERSIONS_ID_FRET2TONE:
            self.performSegue(withIdentifier: KB.QUIZ_TYPE_SELECT_PERFORM_SEGUE_IDENTIFIER_CELL_TOQUIZFRET2TONE, sender: nil)
            
        case KB.QUIZ_VERSIONS_ID_TONE2FRET:
            self.performSegue(withIdentifier: KB.QUIZ_TYPE_SELECT_PERFORM_SEGUE_IDENTIFIER_CELL_TOQUIZTONE2FRET, sender: nil)
            
        default:
            break
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // セル押下時の画面間の値渡しについて定義する
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let selectedIndex = quizTypeSelectTableView.indexPathForSelectedRow!
        let levelId = KB.getQuizLevelIdFromQuizTypeId(quizTypeId: selectedIndex.row)
        let versionId = KB.getQuizVersionIdFromQuizTypeId(quizTypeId: selectedIndex.row)
        
        switch versionId {
            
        case KB.QUIZ_VERSIONS_ID_FRET2TONE:
            let quizFret2ToneViewController = segue.destination as! QuizFret2ToneViewController
            quizFret2ToneViewController.quizLevelId = levelId
            
        case KB.QUIZ_VERSIONS_ID_TONE2FRET :
            let quizTone2FretViewController = segue.destination as! QuizTone2FretViewController
            quizTone2FretViewController.quizLevelId = levelId
            
        default :
            break
        }
    }
    
    // プロフィール欄を初期化する
    func initProfileView () {
        
        let rankId : Int = KB.getUserRank()
        
        self.quizTypeSelectRankImageView.image = UIImage(named : KB.PROFILE_RANKS_ICON_IMAGEPATHES[rankId])
        self.quizTypeSelectRankNameLavel.text = "ランク：" + KB.getUserRankName()
        self.quizTypeSelectRankExplanation.text = KB.getUserRankExplanation()
    }
}

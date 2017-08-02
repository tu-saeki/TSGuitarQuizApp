//
//  MenuViewController.swift
//  TSGuitarQuizApp
//
//  Created by nttr on 2017/07/20.
//  Copyright © 2017年 nttr. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // メニューテーブルビュー
    @IBOutlet var menuTableView : UITableView!
    
    // ランク画像
    @IBOutlet var menuRankImageView : UIImageView!
    
    // ランク名
    @IBOutlet var menuRankNameLavel : UILabel!
    
    // ランク説明
    @IBOutlet var menuRankExplanation : UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        menuTableView.dataSource = self
        menuTableView.delegate = self
        menuTableView.tableFooterView = UIView()
        
        let nib = UINib(nibName: KB.MENU_TABLE_NIB_NAME, bundle: Bundle.main)
        menuTableView.register(nib, forCellReuseIdentifier: KB.MENU_TABLE_FOR_CELL_REUSE_IDENTIFIER)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        initProfileView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // テーブルの表示個数を定義する
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return KB.MENU_TITLE_NAMES.count
    }
    
    // テーブルの表示内容を定義する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // cellを取得する
        let tmpCell = tableView.dequeueReusableCell(withIdentifier: KB.MENU_TABLE_FOR_CELL_REUSE_IDENTIFIER) as! MenuTableViewCell
        
        // cellのパーツにセットする
        tmpCell.menuIcon.image = UIImage(named : KB.MENU_TITLE_IMAGEPATHES[indexPath.row])
        tmpCell.menuTitleLabel.text = KB.MENU_TITLE_NAMES[indexPath.row]
        tmpCell.menuExplanationTextView.text = KB.MENU_TITLE_EXPLANATIONS[indexPath.row]
        
        return tmpCell
    }
    
    // セル押下時の画面遷移について定義する
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        switch indexPath.row {
            
        case KB.MENU_TITLE_ID_QUIZTYPESELECT:
            self.performSegue(withIdentifier: KB.MENU_TABLE_PERFORF_SEGUE_IDENTIFIER_CELL_TOQUIZTYPESELECT, sender: nil)
            
        case KB.MENU_TITLE_ID_PROFILE:
            self.performSegue(withIdentifier: KB.MENU_TABLE_PERFORM_SEQUE_IDENTIFIER_CELL_TOPROFILE, sender: nil)
            
        case KB.MENU_TITLE_ID_SETTINGS:
            self.performSegue(withIdentifier: KB.MENU_TABLE_PERFORM_SEGUE_IDENTIFIER_CELL_TOSETTINGS, sender: nil)
            
        case KB.MENU_TITLE_ID_EXIT:
            self.navigationController?.popToViewController((self.navigationController?.viewControllers[0])!, animated: true)
        
        default:
            break
        }
        
        // テーブルの選択を解除する
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
//    // セル押下時の画面間の値渡しについて定義する
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        
//        // 押下されたセルのインデックスを取得する
//        let selectedIndex = menuTableView.indexPathForSelectedRow?.row
//        
//        // インデックス別に遷移先を変更する
//        switch selectedIndex {
//            
//        // レベル選択画面を押下した場合
//        case KB.MENU_TITLE_ID_LEVELSELECT :
//            
//            let levelSelectViewController = segue.distination as! LevelSelectViewController
//            
//        default:
//            break
//        }
//    }
    
    // プロフィール欄を初期化する
    func initProfileView () {
        
        let rankId : Int = KB.getUserRank()

        self.menuRankImageView.image = UIImage(named : KB.PROFILE_RANKS_ICON_IMAGEPATHES[rankId])
        self.menuRankNameLavel.text = "ランク：" + KB.getUserRankName()
        self.menuRankExplanation.text = KB.getUserRankExplanation()
    }
    
}

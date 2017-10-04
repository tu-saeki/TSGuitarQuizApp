 //
//  KB.swift
//  TSGuitarQuizApp
//
//  Created by nttr on 2017/07/20.
//  Copyright © 2017年 nttr. All rights reserved.
//

import Foundation

// 共通定数・メソッド（KnowledgeBase）を表すクラス
class KB {
    
    // 各画面の名称
    static let VIEW_CONTROLLER_NAME_TOP : String = "Top"
    static let VIEW_CONTROLLER_NAME_MENU : String = "Menu"
    static let VIEW_CONTROLLER_NAME_QUIZTYPESELECT : String = "QuizTypeSelect"
    static let VIEW_CONTROLLER_NAME_QUIZFRET2TONE : String = "QuizFret2Tone"
    static let VIEW_CONTROLLER_NAME_QUIZTONE2FRET : String = "QuizTone2Fret"
    static let VIEW_CONTROLLER_NAME_QUIZ_RESULT : String = "Result"
    static let VIEW_CONTROLLER_NAME_SETTINGS : String = "Settings"
    static let VIEW_CONTROLLER_NAME_PROFILE : String = "Profile"
    
    // チェックボックスの画像パス
//    static let CHECKBOX_CHECKED_IMAGEPATH : String = "checkbox_checked_icon.png"
//    static let CHECKBOX_UNCHECKED_IMAGEPATH : String = "checkbox_unchecked_icon.png"
    static let CHECKBOX_CHECKED_IMAGEPATH : String = "checkbox_checked_icon2.png"
    static let CHECKBOX_UNCHECKED_IMAGEPATH : String = "checkbox_unchecked_icon2.png"
    
    // 指定個数だけ乱数値を取得する
    // @param minValue 最小値
    // @param maxValue 最大値
    // @param numValue 個数
    // @return [乱数値]
    static func getRandomValues (minValue : Int, maxValue : Int, numValue : Int) -> [Int] {
        
        var tmpValues : [Int] = []
        
        while(true){
            
            // 指定個数取得できた場合には、ループを抜ける
            if(tmpValues.count >= numValue){
                
                break
            }
            
            // 乱数で値を取得する
            let tmpValue : Int = (Int)(arc4random_uniform(UInt32(maxValue + 1 - minValue))) + minValue
            
            // 被りが無いか確認する
            var tmpMatchFlag : Bool = false
            for i in 0 ..< tmpValues.count {
                
                if(tmpValues[i] == tmpValue){
                    
                    tmpMatchFlag = true
                    break
                }
            }
            
            // 被りが無い場合には、値を追加する
            if(!tmpMatchFlag) {
                
                tmpValues.append(tmpValue)
            }
        }
        
        return tmpValues
    }
    
    /*------- メニュー選択画面　-------*/

    static let MENU_TITLE_ID_QUIZTYPESELECT : Int = 0
    static let MENU_TITLE_ID_SETTINGS : Int = 1
    static let MENU_TITLE_ID_PROFILE : Int = 2
    static let MENU_TITLE_ID_EXIT : Int = 3

    static let MENU_TITLE_NAMES : [String] = [
        "ゲーム開始♪",
        "設定変更♪",
        "過去の実績♪",
        "終了♪"
    ]
    
    static let MENU_TITLE_EXPLANATIONS : [String] = [
        "プレイするフレット当て、音当てのゲームを選択します♪",
        "各弦のチューニングや、変音記号（♯、♭）の設定を行います♪",
        "挑戦回数やベストスコアなどを確認します♪",
        "ゲームを終了します♪"
    ]
    
    static let MENU_TITLE_IMAGEPATHES : [String] = [
        "menu_icon_start_gray.png",
        "menu_icon_5lines_gray.png",
        "menu_icon_metronorm_gray.png",
        "menu_icon_frameset_gray.png"
    ]
    
    static let MENU_TABLE_NIB_NAME : String = "MenuTableViewCell"
    static let MENU_TABLE_FOR_CELL_REUSE_IDENTIFIER : String = "menuTableViewCell"
    
    static let MENU_TABLE_PERFORM_SEGUE_IDENTIFIER_CELL_TOSETTINGS = "toSettings"
    static let MENU_TABLE_PERFORM_SEQUE_IDENTIFIER_CELL_TOPROFILE = "toProfile"
    static let MENU_TABLE_PERFORF_SEGUE_IDENTIFIER_CELL_TOQUIZTYPESELECT = "toQuizTypeSelect"

    
    /*------- ゲーム種別選択画面 -------*/
    
    static let QUIZ_TYPE_SELECT_TITLE_EXPLANATIONS : [String] = [
        "弦とフレットから、1オクターブ分（ド〜高ド）の音を当てます♪",
        "1オクターブ分（ド〜高ド）の音から、弦とフレットを当てます♪",
        "弦とフレットから、2オクターブ分（ド〜高高ド）の音を当てます♪",
        "2オクターブ分（ド〜高高ド）の音から、弦とフレットを当てます♪",
        "弦とフレットから、全範囲の音を当てます♪",
        "全範囲の音から、弦とフレットを当てます♪"
    ]

    static let QUIZ_TYPE_SELECT_TABLE_NIB_NAME : String = "QuizTypeSelectTableViewCell"
    static let QUIZ_TYPE_SEELCT_FOR_CELL_REUSE_IDENTIFIER : String = "quizTypeSelectTableViewCell"
    
    static let QUIZ_TYPE_SELECT_PERFORM_SEGUE_IDENTIFIER_CELL_TOQUIZFRET2TONE : String = "toQuizFret2Tone"
    static let QUIZ_TYPE_SELECT_PERFORM_SEGUE_IDENTIFIER_CELL_TOQUIZTONE2FRET : String = "toQuizTone2Fret"

    
    /*------- フレット→音　選択画面 -------*/
    
    static let QUIZ_FRET2TONE_TABLE_NIB_NAME : String = "QuizFret2ToneTableViewCell"
    static let QUIZ_FRET2TONE_FOR_CELL_REUSE_IDENTIFIER : String = "quizFret2ToneTableViewCell"
    
    static let QUIZ_FRET2TONE_PEFORM_SEGUE_IDENTIFIER_CELL_TORESULT : String = "toResult"
    
    /*------- 音→フレット　選択画面 -------*/
    
    static let QUIZ_TONE2FRET_TABLE_NIB_NAME : String = "QuizTone2FretTableViewCell"
    static let QUIZ_TONE2FRET_FOR_CELL_REUSE_IDENTIFIER : String = "quizTone2FretTableViewCell"
    
    static let QUIZ_TONE2FRET_PERFORM_SEGUE_IDENTIFIER_CELL_TORESULT : String = "toResultFromTone2Fret"
    
    /*------- 結果表示画面 -------*/
    
    static let QUIZ_RESULT_TABLE_NIB_NAME : String = "QuizResultTableViewCell"
    static let QUIZ_RESULT_FOR_CELL_REUSE_IDENTIFIER : String = "quizResultTableViewCell"
    
    static let QUIZ_RESULT_IMAGEPATH_SUCCESS : String = "quiz_result_success_icon.png"
    static let QUIZ_RESULT_IMAGEPATH_FAILURE : String = "quiz_result_failure_icon.jpg"
    
    /*------- 設定画面 -------*/
    
    /*------- プロフィール画面 -------*/
    
    /*------- ゲーム種別 -------*/
    
    static let QUIZ_TYPES_ID_BEGINNER_FRET2TONE = 0
    static let QUIZ_TYPES_ID_BEGINNER_TONE2FRET = 1
    static let QUIZ_TYPES_ID_MIDDLE_FRET2TONE = 2
    static let QUIZ_TYPES_ID_MIDDLE_TONE2FRET = 3
    static let QUIZ_TYPES_ID_ADVANCED_FRET2TONE = 4
    static let QUIZ_TYPES_ID_ADVANCED_TONE2FRET = 5
    
    static let QUIZ_TYPES_NAMES : [String] = [
        "フレット→音　初級",
        "音→フレット　初級",
        "フレット→音　中級",
        "音→フレット　中級",
        "フレット→音　上級",
        "音→フレット　上級"
    ]
    
    static let QUIZ_TYPES_NAMEENS : [String] = [
        "fret2tone_beginner",
        "tone2fret_beginner",
        "fret2tone_middle",
        "tone2fret_middle",
        "fret2tone_higher",
        "tone2fret_higher"
    ]
    
    static let QUIZ_TYPES_IMAGEPATHES : [String] = [
        "note_icon_1.png",
        "note_icon_1_gray.png",
        "note_icon_1_green.png",
        "note_icon_1_darkblue.png",
        "note_icon_1_yellow.png",
        "note_icon_1_orange.png"
    ]
    
    static let QUIZ_LEVELS_ID_BEGINNER = 0
    static let QUIZ_LEVELS_ID_MIDDLE = 1
    static let QUIZ_LEVELS_ID_ADVANCED = 2
    
    // クイズ種別IDからクイズレベルIDを取得する
    // @param quizTypeId クイズ種別ID
    // @return クイズレベルID
    static func getQuizLevelIdFromQuizTypeId (quizTypeId : Int) -> Int {
        
        var levelId : Int = 0

        switch quizTypeId {
        case QUIZ_TYPES_ID_BEGINNER_FRET2TONE :
            levelId = QUIZ_LEVELS_ID_BEGINNER
            
        case QUIZ_TYPES_ID_BEGINNER_TONE2FRET :
            levelId = QUIZ_LEVELS_ID_BEGINNER
            
        case QUIZ_TYPES_ID_MIDDLE_FRET2TONE :
            levelId = QUIZ_LEVELS_ID_MIDDLE
            
        case QUIZ_TYPES_ID_MIDDLE_TONE2FRET :
            levelId = QUIZ_LEVELS_ID_MIDDLE
            
        case QUIZ_TYPES_ID_ADVANCED_FRET2TONE :
            levelId = QUIZ_LEVELS_ID_ADVANCED
            
        case QUIZ_TYPES_ID_ADVANCED_TONE2FRET :
            levelId = QUIZ_LEVELS_ID_ADVANCED
            
        default:
            break
        }
        return levelId
    }
    
    static let QUIZ_VERSIONS_ID_TONE2FRET = 0
    static let QUIZ_VERSIONS_ID_FRET2TONE = 1
    
    // クイズ種別IDからクイズバージョンIDを取得する
    // @param quizTypeId クイズ種別ID
    // @return クイズバージョンID
    static func getQuizVersionIdFromQuizTypeId (quizTypeId : Int) -> Int {
        
        var versionId : Int = 0
        
        switch quizTypeId {
            
        case QUIZ_TYPES_ID_BEGINNER_FRET2TONE :
            versionId = QUIZ_VERSIONS_ID_FRET2TONE
            
        case QUIZ_TYPES_ID_BEGINNER_TONE2FRET :
            versionId = QUIZ_VERSIONS_ID_TONE2FRET
            
        case QUIZ_TYPES_ID_MIDDLE_FRET2TONE :
            versionId = QUIZ_VERSIONS_ID_FRET2TONE
            
        case QUIZ_TYPES_ID_MIDDLE_TONE2FRET :
            versionId = QUIZ_VERSIONS_ID_TONE2FRET
            
        case QUIZ_TYPES_ID_ADVANCED_FRET2TONE :
            versionId = QUIZ_VERSIONS_ID_FRET2TONE
            
        case QUIZ_TYPES_ID_ADVANCED_TONE2FRET :
            versionId = QUIZ_VERSIONS_ID_TONE2FRET
            
        default :
            break
        }
        return versionId
    }
    
    // クイズレベルIDとクイズバージョンIDからクイズ種別IDを取得する
    // @param quizLevelId クイズレベルID
    // @param quizVersionId クイズバージョンID
    static func getQuizTypeIdFromQuizLevelIdQuizVersionId (quizLevelId : Int, quizVersionId : Int) -> Int {
        
        var typeId : Int = 0
        
        switch quizLevelId {
            
        case QUIZ_LEVELS_ID_BEGINNER :
            
            switch quizVersionId {
                
            case QUIZ_VERSIONS_ID_FRET2TONE :
                typeId = QUIZ_TYPES_ID_BEGINNER_FRET2TONE
                
            case QUIZ_VERSIONS_ID_TONE2FRET :
                typeId = QUIZ_TYPES_ID_BEGINNER_TONE2FRET
                
            default :
                break
            }
            
        case QUIZ_LEVELS_ID_MIDDLE :
            
            switch quizVersionId {
                
            case QUIZ_VERSIONS_ID_FRET2TONE :
                typeId = QUIZ_TYPES_ID_MIDDLE_FRET2TONE
                
            case QUIZ_VERSIONS_ID_TONE2FRET :
                typeId = QUIZ_TYPES_ID_MIDDLE_TONE2FRET
                
            default :
                break
            }
            
        case QUIZ_LEVELS_ID_ADVANCED :
            
            switch quizVersionId {
                
            case QUIZ_VERSIONS_ID_FRET2TONE :
                typeId = QUIZ_TYPES_ID_ADVANCED_FRET2TONE
                
            case QUIZ_VERSIONS_ID_TONE2FRET :
                typeId = QUIZ_TYPES_ID_ADVANCED_TONE2FRET
                
            default :
                break
            }
        default :
            break
        }
        
        return typeId
    }
    
    static let QUIZ_TYPES_PASSING_SCORE_RATE : [Int] = [
        90,
        90,
        85,
        85,
        80,
        80
    ]
    
    static let QUIZ_TYPES_GREAT_SCORE_RATE : [Int] = [
        100,
        100,
        95,
        95,
        90,
        90
    ]
    
    static let QUIZ_TYPES_PASSING_TIMESEC : [Int] = [
        100,
        100,
        200,
        200,
        400,
        400
    ]
    
    static let QUIZ_TYPES_GREAT_TIMESEC : [Int] = [
        60,
        60,
        120,
        120,
        240,
        240
    ]
        
    static let QUIZ_TYPES_NUMCHOICES : [Int] = [
        3,
        3,
        3,
        3,
        3,
        3
    ]
    
    static let QUIZ_TYPES_NUMQUIZ : [Int] = [
        10,
        10,
        20,
        20,
        40,
        40
    ]
    
    static let QUIZ_TYPES_TONES : [[Int]] = [
        [12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24],
        [12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24],
        [12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36],
        [12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36],
        [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47],
        [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47]
    ]
    
    // クイズ種別IDから、ギターフレット範囲内に収まる音階値を求める
    // @param quizTypeId クイズ種別ID
    // @return [音階値]
    static func getQuizTypesTonesInGuitarFrets (quizTypeId : Int) -> [Int] {
        
        // ギターの最低・最高音を取得する
        let minMaxId = getMinMaxToneIds()
        let minId : Int = minMaxId[0]
        let maxId : Int = minMaxId[1]
        
        var tmpIds : [Int] = []
        
        for i in 0 ..< QUIZ_TYPES_TONES[quizTypeId].count {
            
            if(minId <= QUIZ_TYPES_TONES[quizTypeId][i] && QUIZ_TYPES_TONES[quizTypeId][i] <= maxId){
                
                tmpIds.append(QUIZ_TYPES_TONES[quizTypeId][i])
            }
        }
        return tmpIds
    }
    
    // クイズ種別IDから、ランダムに音階値を取得する
    // @param quizTypeId クイズ種別ID
    // @return 音階値
    static func getRandomTone (quizTypeId : Int) -> Int {
        
        // ギターフレット範囲内に収まる音階値を取得する
        let toneIds = getQuizTypesTonesInGuitarFrets(quizTypeId: quizTypeId)
        
        let index : Int = (Int)(arc4random_uniform(UInt32(toneIds.count)))
        return toneIds[index]
    }
    
    // クイズ種別IDから、ランダムに音階値を取得する
    // @param quizTypeId クイズ種別ID
    // @param exceptTones 除外したい音階値
    // @return 音階値
    static func getRandomTone (quizTypeId : Int, exceptTones : [Int]) -> Int {
        
        var tone = 0
        
        while(true) {
            
            // ランダムに音階値を取得する
            tone = getRandomTone(quizTypeId: quizTypeId)
            
            // 除外したい音階値に一致するか判定する
            var tmpMatchFlag : Bool = false
            for i in 0 ..< exceptTones.count {
                
                if(tone == exceptTones[i]) {
                    
                    tmpMatchFlag = true
                    break
                }
            }
            
            // 一致しない場合、この音階値で確定する
            if(!tmpMatchFlag) {
                
                break
            }
        }
        
        return tone
    }
    
    // クイズ種別IDから、ランダムに弦IDとフレットID、音階値を取得する
    // @param quizTypeId クイズ種別ID
    // @param tone 音階値
    // @return [弦ID, フレットID, 音階値]
    static func getRandomStringIdFretIdTone (quizTypeId : Int, tone : Int) -> [Int] {
        
        // 音階値に該当する各弦のフレットを取得する
        let fretIds = getFretIdsFromTone(tone: tone)
        
        // 押さえられるフレットが存在する弦を求める
        var stringIds : [Int] = []
        for i in 0 ..< fretIds.count {
            
            if(fretIds[i] >= 0){
                
                stringIds.append(i)
            }
        }
        
        let index : Int = (Int)(arc4random_uniform(UInt32(stringIds.count)))
        let tmpIds : [Int] = [stringIds[index], fretIds[stringIds[index]], tone]
        
        return tmpIds
    }
    
    // クイズ種別IDから、ランダムに弦IDとフレットID、音階値を取得する
    // @param quizTypeId クイズ種別ID
    // @return [弦ID, フレットID, 音階値]
    static func getRandomStringIdFretIdTone (quizTypeId : Int) -> [Int] {
        
        // ギターフレット内に収まる音階値を取得する
        let tone = getRandomTone(quizTypeId: quizTypeId)

        return getRandomStringIdFretIdTone(quizTypeId: quizTypeId, tone: tone)
    }
    
    // クイズ種別IDから、ランダムに弦IDとフレットIDを取得する
    // @param quizTypeId クイズ種別ID
    // @param tone 音階値
    // @return [弦ID, フレットID]
    static func getRandomStringIdFretId (quizTypeId: Int, tone : Int) -> [Int] {
        
        let stringIdFretIdTone = getRandomStringIdFretIdTone(quizTypeId: quizTypeId, tone: tone)
        let stringIdFretId : [Int] = [stringIdFretIdTone[0], stringIdFretIdTone[1]]
        
        return stringIdFretId
    }
    
    // クイズ種別IDから、ランダムに弦IDとフレットIDを取得する
    // @param quizTypeId クイズ種別ID
    // @return [弦ID, フレットID]
    static func getRandomStringIdFretId (quizTypeId : Int) -> [Int] {

        let stringIdFretIdTone = getRandomStringIdFretIdTone(quizTypeId: quizTypeId)
        let stringIdFretId : [Int] = [stringIdFretIdTone[0], stringIdFretIdTone[1]]
        
        return stringIdFretId
    }
    
    // クイズ種別IDから、ランダムに弦IDとフレットIDを取得する
    // @param quizTypeId クイズ種別ID
    // @param exceptStringIdFretIds 除外したいフレットIDと弦ID（[[弦ID, フレットID]]）
    // @return [弦ID, フレットID]
    static func getRandomStringIdFretId (quizTypeId : Int, exceptStringIdFretIds : [[Int]]) -> [Int] {
        
        var stringIdFretId : [Int] = []
        
        while (true) {
            
            // ランダムに弦IDとフレットIDを取得する
            stringIdFretId = getRandomStringIdFretId(quizTypeId: quizTypeId)
            
            // 除外したいフレットIDと弦IDに一致するか判定する
            var tmpMatchFlag : Bool = false
            for i in 0 ..< exceptStringIdFretIds.count {
                
                if(stringIdFretId[0] == exceptStringIdFretIds[i][0]
                    && stringIdFretId[1] == exceptStringIdFretIds[i][1]){
                    
                    tmpMatchFlag = true
                    break
                }
            }
            
            // 一致しない場合、この組み合わせで確定する
            if(!tmpMatchFlag){
                
                break
            }
        }
        return stringIdFretId
    }
    
    // クイズ種別IDから、問題の選択肢（弦ID、フレットID、音階値の組み合わせ）を取得する
    // @param quizTypeId クイズ種別ID
    // @param preStringIdFretIdTones 前問までの正解（弦ID、フレットID、音階値の組み合わせ）
    // @return [[正解の弦ID, 正解のフレットID, 正解の音階値], [ダミーの弦ID, ダミーのフレットID, ダミーの音階値], ...]
    static func getStringIdFretIdTonesForQuiz (quizTypeId : Int, preStringIdFretIdTones : [[Int]]) -> [[Int]] {
        
        // 前問までの正解（弦IDとフレットIDの組み合わせ）を作成する
        var preStringIdFretId : [[Int]] = []
        for i in 0 ..< preStringIdFretIdTones.count {
            
            let tmpPreStringIdFretId : [Int] = [preStringIdFretIdTones[i][0], preStringIdFretIdTones[i][1]]
            preStringIdFretId.append(tmpPreStringIdFretId)
        }
        
        // 正解の弦ID, フレットIDを取得する
        let correctStringIdFretId = getRandomStringIdFretId(quizTypeId: quizTypeId, exceptStringIdFretIds: preStringIdFretId)
        
        // 正解の音階値を取得する
        let correctTone = getToneFromStringIdFretId(stringId: correctStringIdFretId[0], fretId: correctStringIdFretId[1])
        
        // 弦IDとフレットID、音階値の一時格納用配列を作成する
        var stringIdFretIds : [[Int]] = []
        stringIdFretIds.append(correctStringIdFretId)
        
        var tones : [Int] = []
        tones.append(correctTone)
        
        // 正解の音階値に被らないように、選択肢を取得する
        let numDummies : Int = 2
        for _ in 0 ..< numDummies {
            
            // 選択肢の音階値を取得する
            let tmpDummyTone = getRandomTone(quizTypeId: quizTypeId, exceptTones: tones)
            
            // 配列に格納する
            stringIdFretIds.append(getRandomStringIdFretId(quizTypeId: quizTypeId, tone: tmpDummyTone))
            tones.append(tmpDummyTone)
        }
        
        // 出力用に配列をマージする
        var stringIdFretIdTones : [[Int]] = []
        for i in 0 ..< stringIdFretIds.count {
            
            let tmpStringIdFretIdTone : [Int] = [stringIdFretIds[i][0], stringIdFretIds[i][1], tones[i]]
            stringIdFretIdTones.append(tmpStringIdFretIdTone)
        }
        
        return stringIdFretIdTones
    }
    
    
    /*------- 音符種別 -------*/
    
    static let MUSIC_NOTE_PITCHES_ID_C = 0
    static let MUSIC_NOTE_PITCHES_ID_D = 1
    static let MUSIC_NOTE_PITCHES_ID_E = 2
    static let MUSIC_NOTE_PITCHES_ID_F = 3
    static let MUSIC_NOTE_PITCHES_ID_G = 4
    static let MUSIC_NOTE_PITCHES_ID_A = 5
    static let MUSIC_NOTE_PITCHES_ID_B = 6
    
    static let MUSIC_NOTE_PITCHES_NAMES : [String] = [
        "ド",
        "レ",
        "ミ",
        "ファ",
        "ソ",
        "ラ",
        "シ"
    ]
    
    static let MUSIC_NOTE_PITCHES_NAMEENS : [String] = [
        "C",
        "D",
        "E",
        "F",
        "G",
        "A",
        "B"
    ]
    
    static let MUSIC_NOTE_PITCHES_TONES : [Int] = [
        0,
        2,
        4,
        5,
        7,
        9,
        11
    ]
    
    static let MUSIC_NOTE_ACCIDENTAL_ID_NORMAL = 0
    static let MUSIC_NOTE_ACCIDENTAL_ID_FLAT = 1
    static let MUSIC_NOTE_ACCIDENTAL_ID_SHARP = 2
    
    static let MUSIC_NOTE_ACCIDENTAL_NAMES : [String] = [
        "",
        "♭",
        "♯"
    ]
    
    static let MUSIC_NOTE_ACCIDENTAL_NAMEENS : [String] = [
        "",
        "flat",
        "sharp"
    ]
    
    static let MUSIC_NOTE_ACCIDENTAL_TONES : [Int] = [
        0,
        -1,
        1
    ]
    
    static let MUSIC_NOTE_OCTAVES_ID_LOW = 0
    static let MUSIC_NOTE_OCTAVES_ID_MIDDLE = 1
    static let MUSIC_NOTE_OCTAVES_ID_HIGH = 2
    static let MUSIC_NOTE_OCTAVES_ID_HIGHHIGH = 3
    
    static let MUSIC_NOTE_OCTAVES_NAMES : [String] = [
        "低",
        "",
        "高",
        "高高"
    ]
    
    static let MUSIC_NOTE_OCTAVES_NAMEENS : [String] = [
        "low",
        "middle",
        "high",
        "highhigh"
    ]
    
    static let MUSIC_NOTE_OCTAVES_TONES : [Int] = [
        0,
        12,
        24,
        36,
    ]
    
    // 音階値を取得する
    // （低ドを0として、1音階ごとに1増加させる）
    // @param octaveId オクターブID
    // @param pitchId 音名ID
    // @param accidentalId 変音記号ID
    static func getTone (ocvaveId : Int, pitchId : Int, accidentalId : Int) -> Int {
        
        return MUSIC_NOTE_OCTAVES_TONES[ocvaveId] + MUSIC_NOTE_PITCHES_TONES[pitchId] + MUSIC_NOTE_ACCIDENTAL_TONES[accidentalId]
    }
    
    // オクターブIDを取得する
    // @param tone 音階値
    // @return オクターブID
    static func getOctaveId (tone : Int) -> Int {
        
        var tmpId : Int = MUSIC_NOTE_OCTAVES_TONES.count - 1
        for i in 0 ..< (MUSIC_NOTE_OCTAVES_TONES.count - 1) {
            
            if(MUSIC_NOTE_OCTAVES_TONES[i] <= tone && tone < MUSIC_NOTE_OCTAVES_TONES[i + 1]){
                
                tmpId = i
                break
            }
        }
        return tmpId
    }
    
    // オクターブIDと音名IDを取得する
    // @param tone 音階値
    // @param accidentalId 変音記号ID（♯と♭基準のどちらで取るか）
    // @return [オクターブID, 音名ID]
    static func getOctavePitchId (tone : Int, accidentalId : Int) -> [Int] {
        
        // オクターブIDを取得する
        let octaveId = getOctaveId(tone: tone)
        
        // オクターブ分の音階値を減算した音階値を求める
        let tmpTone = tone - MUSIC_NOTE_OCTAVES_TONES[octaveId]
        
        var tmpId : Int = MUSIC_NOTE_PITCHES_TONES.count - 1
        for i in 0 ..< (MUSIC_NOTE_PITCHES_TONES.count - 1) {
            
            if(accidentalId ==  MUSIC_NOTE_ACCIDENTAL_ID_SHARP) {
                if(MUSIC_NOTE_PITCHES_TONES[i] <= tmpTone && tmpTone < MUSIC_NOTE_PITCHES_TONES[i + 1]){
                
                    tmpId = i
                    break
                }
            }
            else if (accidentalId == MUSIC_NOTE_ACCIDENTAL_ID_FLAT){
                if(tmpTone <= MUSIC_NOTE_PITCHES_TONES[i]) {
                    
                    tmpId = i
                    break
                }
            }
        }
        
        let tmpIds : [Int] = [octaveId, tmpId]
        
        return tmpIds
    }
    
    // オクターブIDと音名ID、変音記号IDを取得する
    // @param tone 音階値
    // @param accidentalId 変音記号ID（♯と♭基準のどちらで取るか）
    // @return [オクターブID, 音名ID, 変音記号ID]
    static func getOctavePitchAccidentalId (tone : Int, accidentalId : Int) -> [Int] {
    
        // オクターブIDと音名IDを取得する
        let octavePitchId = getOctavePitchId(tone: tone, accidentalId: accidentalId)
        
        let normalTone = getTone(ocvaveId: octavePitchId[0], pitchId: octavePitchId[1], accidentalId: MUSIC_NOTE_ACCIDENTAL_ID_NORMAL)

        for i in 0 ..< MUSIC_NOTE_ACCIDENTAL_TONES.count {
            
            if(normalTone + MUSIC_NOTE_ACCIDENTAL_TONES[i] == tone){
                
                return [octavePitchId[0], octavePitchId[1], i]
            }
        }
        return [octavePitchId[0], octavePitchId[1], 0]
    }
    
    // オクターブIDと音名ID、変音記号IDから音階名称を取得する
    // @param octaveId オクターブID
    // @param pitchId 音名ID
    // @param accidentalId 変音記号ID
    // @return 音階名称
    static func getToneName (octaveId : Int, pitchId : Int, accidentalId : Int) -> String{
        
        return MUSIC_NOTE_OCTAVES_NAMES[octaveId] + MUSIC_NOTE_PITCHES_NAMES[pitchId] + MUSIC_NOTE_ACCIDENTAL_NAMES[accidentalId]
    }
    
    // 音階値から音階名称を取得する
    // @param tone 音階値
    // @param accidentalId 変音記号ID
    // @return 音階名称
    static func getToneName (tone : Int, accidentalId : Int) -> String {
        
        let tmpIds : [Int] = getOctavePitchAccidentalId(tone: tone, accidentalId: accidentalId)
        return getToneName(octaveId: tmpIds[0], pitchId: tmpIds[1], accidentalId: tmpIds[2])
    }
    
    
    /*------- ギター関連 -------*/
    
    static let MUSIC_GUITAR_FRET_NOT_PRESSING_IMAGEPATH : String = "fret_not_pressing.png"
    static let MUSIC_GUITAR_FRET_PRESSING_IMAGEPATH : String = "fret_pressing.png"
    
    static let MUSIC_GUITAR_STRINGS_DEFAULT_BASE_TONES : [Int] = [
        4,
        9,
        14,
        19,
        23,
        28
    ]
    
    static let MUSIC_GUITAR_STRINGS_DEFAULT_NUM_FRETS : [Int] = [
        12,
        12,
        12,
        12,
        12,
        12
    ]
    
    static let MUSIC_GUITAR_STRINGS_NAMES : [String] = [
        "6",
        "5",
        "4",
        "3",
        "2",
        "1"
    ]
    
    // 弦IDとフレットIDから音階値を取得する
    // @param stringId 弦ID
    // @param fretId フレットID
    // @return 音階値
    static func getToneFromStringIdFretId (stringId : Int, fretId : Int) -> Int{
        
        return getMusicGuitarStringsBaseTone(index: stringId) + fretId
//        return MUSIC_GUITAR_STRINGS_DEFAULT_BASE_TONES[stringId] + fretId
    }
    
    // 音階値と弦IDから、フレットIDを取得する
    // @param tone 音階値
    // @param stringId 弦ID
    // @return フレットID（見つからない場合には、-1を返す）
    static func getFretIdFromToneStringId (tone : Int, stringId : Int) -> Int {
        
        let fretId = tone - getMusicGuitarStringsBaseTone(index: stringId)
//        let fretId = tone - MUSIC_GUITAR_STRINGS_DEFAULT_BASE_TONES[stringId]
        if(0 <= fretId && fretId <= MUSIC_GUITAR_STRINGS_DEFAULT_NUM_FRETS[stringId]){
            
            return fretId
        }
        return -1
    }
    
    // 音階値から、各弦のフレットIDの一覧を取得する
    // @param tone 音階値
    // @return [6弦のフレットID, 5弦のフレットID, ... , 1弦のフレットID]（該当フレットが無い弦は-1を返す）
    static func getFretIdsFromTone (tone : Int) -> [Int] {
        
        var tmpIds : [Int] = []
        
        for i in 0 ..< MUSIC_GUITAR_STRINGS_DEFAULT_NUM_FRETS.count {
            
            tmpIds.append(getFretIdFromToneStringId(tone: tone, stringId: i))
        }
        return tmpIds
    }
    
    // 弦IDから、音階値の最大・最小値を取得する
    // @param stringId 弦ID
    // @return [最小値, 最大値]
    static func getMinMaxTonesFromStringId (stringId : Int) -> [Int] {

        let tmpIds : [Int] = [getMusicGuitarStringsBaseTone(index: stringId), getMusicGuitarStringsBaseTone(index: stringId) + MUSIC_GUITAR_STRINGS_DEFAULT_NUM_FRETS[stringId]]
//        let tmpIds : [Int] = [MUSIC_GUITAR_STRINGS_DEFAULT_BASE_TONES[stringId], MUSIC_GUITAR_STRINGS_DEFAULT_BASE_TONES[stringId] + MUSIC_GUITAR_STRINGS_DEFAULT_NUM_FRETS[stringId]]
        
        return tmpIds
    }
    
    // ギターの音階値の最大・最小値を取得する
    // @return [最小値, 最大値]
    static func getMinMaxToneIds () -> [Int] {
        
        var minId : Int = -1
        var maxId : Int = -1
        
        for i in 0 ..< MUSIC_GUITAR_STRINGS_NAMES.count {
            
            let tmpIds = getMinMaxTonesFromStringId(stringId: i)
            if(maxId == -1) {
                
                minId = tmpIds[0]
                maxId = tmpIds[1]
                continue
            }
            
            if(minId > tmpIds[0]) {
                
                minId = tmpIds[0]
            }
            if(maxId < tmpIds[1]) {
                
                maxId = tmpIds[1]
            }
        }
        
        let tmpIds : [Int] = [minId, maxId]
        return tmpIds
    }
    

    /*------- ユーザデータ　------*/

    static let PROFILE_RANKS_ID_AMATEUR = 0 // 素人
    static let PROFILE_RANKS_ID_BEGINNER = 1 // 初級
    static let PROFILE_RANKS_ID_HIGH_BEGINNER = 2 // 初中級
    static let PROFILE_RANKS_ID_INTERMEDIATE = 3 // 中級
    static let PROFILE_RANKS_ID_HIGH_INTERMEDIATE = 4 // 中上級
    static let PROFILE_RANKS_ID_ADVANCED = 5 // 上級
    static let PROFILE_RANKS_ID_EXPERT = 6 // 達人
    
    static let PROFILE_RANKS_NAMES : [String] = [
        "素人",
        "初段",
        "二段",
        "三段",
        "四段",
        "五段",
        "名人"
    ]
    
    static let PROFILE_RANKS_NAMEENS : [String] = [
        "amateur",
        "beginner",
        "high_beginner",
        "intermediate",
        "high_intermediate",
        "advanced",
        "expert"
    ]
    
    static let PROFILE_RANKS_ICON_IMAGEPATHES : [String] = [
        "profile_rank_icon_amateur.png",
        "profile_rank_icon_beginner.png",
        "profile_rank_icon_high_beginner.png",
        "profile_rank_icon_intermediate.png",
        "profile_rank_icon_high_intermediate.png",
        "profile_rank_icon_advanced.png",
        "profile_rank_icon_expert.png"
    ]
    
    static let PROFILE_RANKS_EXPLANATIONS : [String] = [
        "ギターという楽器は知っているけど、あくまで聴く側。",
        "演奏に少し興味を持ち始めたフレットプレイヤー初心者。",
        "簡単な音については演奏の前提知識あり。3歩前進。",
        "ギターの音階はわかります、と言えたり言えなかったり。",
        "段々と演奏者側の世界に入り始めたセミプロ。",
        "上級者になれそうでなってる？フレットの知識は完璧。",
        "人間とは別次元。プロのフレットプレイヤー♪"
    ]
    
    // UserDefaultsのクイズクリア有無のキー
    static let USERDEFAULTS_KEY_QUIZ_TYPES_ISCLEAR : String = "quiz_types_isclear"
    
    // UserDefaultsのクイズクリア有無のキーを取得する
    // @param index クイズ種別ID
    // @return キー
    static func getUserDefaultsKeyQuizTypesIsClear (index : Int) -> String {
    
        return USERDEFAULTS_KEY_QUIZ_TYPES_ISCLEAR + "_" + QUIZ_TYPES_NAMEENS[index]
    }

    // クイズのクリア有無を取得する
    // @param index クイズ種別ID
    // @return クリア有無
    static func getQuizTypesIsClear (index : Int) -> Bool {
        
        let ud = UserDefaults.standard
        let isClear = ud.bool(forKey : getUserDefaultsKeyQuizTypesIsClear(index: index)) 

        return isClear
    }
    
    // クイズのクリア有無を取得する
    // @return クリア有無
    static func getQuizTypesIsCleares () -> [Bool] {
        
        var isCleares : [Bool] = []
        
        for i in 0 ..< QUIZ_TYPES_NAMES.count {
            
            isCleares.append(getQuizTypesIsClear(index : i))
        }
        
        return isCleares
    }
    
    // クイズのクリア有無を保存する
    // @param index クイズ種別ID
    // @param isClear クリア有無
    // @return クリア有無
    static func saveQuizTypesIsClear (index : Int, isClear : Bool) {
        
        let ud = UserDefaults.standard
        ud.set(isClear, forKey: getUserDefaultsKeyQuizTypesIsClear(index: index))
        
        ud.synchronize()
    }
    
    // クイズのクリア有無を消去する
    // @param index クイズ種別ID
    // @return クリア有無
    static func removeQuizTypesIsClear (index : Int) {
        
        let ud = UserDefaults.standard
        ud.removeObject(forKey: getUserDefaultsKeyQuizTypesIsClear(index: index))
    }
    
    // クイズのクリア有無を消去する
    static func removeQuizTypesIsCleares () {
        
        for i in 0 ..< QUIZ_TYPES_NAMES.count {
            
            removeQuizTypesIsClear(index: i)
        }
    }
    
    // UserDefaultsの最高得点率のキー
    static let USERDEFAULTS_KEY_QUIZ_TYPES_BEST_SCORE_RATE : String = "quiz_types_best_score_rate"
    
    // UserDefaultsの最高得点率のキーを取得する
    // @param index クイズ種別ID
    // @return キー
    static func getUserDefaultsKeyQuizTypesBestScoreRate (index : Int) -> String {
        
        return USERDEFAULTS_KEY_QUIZ_TYPES_BEST_SCORE_RATE + "_" + QUIZ_TYPES_NAMEENS[index]
    }
    
    // クイズの最高得点率を取得する
    // @param index クイズ種別ID
    // @return 最高得点率
    static func getQuizTypesBestScoreRate (index : Int) -> Int {
        
        let ud = UserDefaults.standard
        let rate = ud.integer(forKey: getUserDefaultsKeyQuizTypesBestScoreRate(index: index)) 
        
        return rate
    }
    
    // 各クイズの最高得点率を取得する
    // @return 最高得点率
    static func getQuizTypesBestScoreRates () -> [Int] {
        
        var rates : [Int] = []
        
        for i in 0 ..< QUIZ_TYPES_NAMES.count {
            
            rates.append(getQuizTypesBestScoreRate(index: i))
        }
        
        return rates
    }
    
    // クイズの最高得点率を保存する
    // @param index クイズ種別ID
    // @param rate 最高得点率
    // @return 最高得点率
    static func saveQuizTypesBestScoreRate (index : Int, rate : Int) {
        
        let ud = UserDefaults.standard
        ud.set(rate, forKey: getUserDefaultsKeyQuizTypesBestScoreRate(index: index))
        
        ud.synchronize()
    }
    
    // ユーザの最高得点率を削除する
    // @param index クイズ種別ID
    static func removeQuizTypesBestScoreRate (index : Int) {
        
        let ud = UserDefaults.standard
        ud.removeObject(forKey: getUserDefaultsKeyQuizTypesBestScoreRate(index: index))
    }
    
    // ユーザの最高得点率を削除する
    static func removeQuizTypesBestScoreRates () {
        
        for i in 0 ..< QUIZ_TYPES_NAMES.count {
            
            removeQuizTypesBestScoreRate(index: i)
        }
    }
    
    // UserDefaultsのベストラップのキー
    static let USERDEFAULTS_KEY_QUIZ_TYPES_BEST_TIMESEC : String = "quiz_types_best_timesec"
    
    // UserDefaultsのベストラップのキーを取得する
    // @param index クイズ種別ID
    // @return キー
    static func getUserDefaultsKeyQuizTypesBestTimeSec (index : Int) -> String {
        
        return USERDEFAULTS_KEY_QUIZ_TYPES_BEST_TIMESEC + "_" + QUIZ_TYPES_NAMEENS[index]
    }
    
    // クイズのベストラップを取得する
    // @param index クイズ種別ID
    // @return ベストラップ
    static func getQuizTypesBestTimeSec (index : Int) -> Int {
        
        let ud = UserDefaults.standard
        let timeSec = ud.integer(forKey: getUserDefaultsKeyQuizTypesBestScoreRate(index: index))
        
        return timeSec
    }
    
    // 各クイズのベストラップを取得する
    // @return ベストラップ
    static func getQuizTypesBestTimeSecs () -> [Int] {
        
        var timeSecs : [Int] = []
        
        for i in 0 ..< QUIZ_TYPES_NAMES.count {
            
            timeSecs.append(getQuizTypesBestTimeSec(index: i))
        }
        
        return timeSecs
    }
    
    // クイズのベストラップを保存する
    // @param index クイズ種別ID
    // @param timeSec ベストラップ
    static func saveQuizTypesBestTimeSec (index : Int, timeSec : Int) {
        
        let ud = UserDefaults.standard
        ud.set(timeSec, forKey: getUserDefaultsKeyQuizTypesBestTimeSec(index: index))
        
        ud.synchronize()
    }
    
    // クイズのベストラップを削除する
    // @param index クイズ種別ID
    static func removeQuizTypesBestTimeSec (index : Int) {
        
        let ud = UserDefaults.standard
        ud.removeObject(forKey: getUserDefaultsKeyQuizTypesBestTimeSec(index: index))
    }
    
    // クイズのベストラップを削除する
    static func removeQuizTypesBestTimeSecs () {
        
        for i in 0 ..< QUIZ_TYPES_NAMES.count {
            
            removeQuizTypesBestTimeSec(index: i)
        }
    }
    
    // UserDefaultsの記録更新日時のキー
    static let USERDEFAULTS_KEY_QUIZ_TYPES_BEST_DATETIME : String = "quiz_types_best_datetime"
    
    // UserDefaultsの記録更新日時のキーを取得する
    // @param index クイズ種別ID
    // @return キー
    static func getUserDefaultsKeyQuizTypesBestDatetime (index : Int) -> String {
        
        return USERDEFAULTS_KEY_QUIZ_TYPES_BEST_DATETIME + "_" + QUIZ_TYPES_NAMEENS[index]
    }
    
    // クイズの記録更新日時を取得する
    // @param index クイズ種別ID
    // @return 記録更新日時
    static func getQuizTypesBestDatetime (index : Int) -> String {
        
        let ud = UserDefaults.standard
        if(ud.object(forKey: getUserDefaultsKeyQuizTypesIsClear(index: index)) == nil){
            
            saveQuizTypesIsClear(index: index, isClear: false)
        }
        return ud.string(forKey: getUserDefaultsKeyQuizTypesBestDatetime(index: index)) ?? ""
    }
    
    // 各クイズの記録更新日時を取得する
    // @return 記録更新日時
    static func getQuizTypesBestDateTimes () -> [String] {
        
        var dateTimes : [String] = []

        for i in 0 ..< QUIZ_TYPES_NAMES.count {
            
            dateTimes.append(getQuizTypesBestDatetime(index: i))
        }
        
        return dateTimes
    }
    
    // 各クイズの記録更新日時を保存する
    // @param index クイズ種別ID
    // @param dateTime 記録更新日時
    static func saveQuizTypesBestDateTime (index : Int, dateTime : String) {
        
        let ud = UserDefaults.standard
        ud.set(dateTime, forKey: getUserDefaultsKeyQuizTypesBestDatetime(index: index))
        
        ud.synchronize()
    }
    
    // 各クイズの記録更新日時を削除する
    // @param index クイズ種別ID
    static func removeQuizTypesBestDateTime (index : Int) {

        let ud = UserDefaults.standard
        ud.removeObject(forKey: getUserDefaultsKeyQuizTypesBestDatetime(index: index))
    }
    
    // 各クイズの記録更新日時を削除する
    static func removeQuizTypesBestDateTimes () {
        
        for i in 0 ..< QUIZ_TYPES_NAMES.count {
            
            removeQuizTypesBestDateTime(index: i)
        }
    }
    
    // UserDefaultsの挑戦回数のキー
    static let USERDEFAULTS_KEY_QUIZ_TYPES_NUM_CHALLENGE : String = "quiz_types_best_num_challenge"
    
    // UserDefaultsの挑戦回数のキーを取得する
    // @param index クイズ種別ID
    // @return キー
    static func getUserDefaultsKeyQuizTypesNumChallenge (index : Int) -> String {
    
        return USERDEFAULTS_KEY_QUIZ_TYPES_NUM_CHALLENGE + "_" + QUIZ_TYPES_NAMEENS[index]
    }
    
    // クイズの挑戦回数を取得する
    // @param index クイズ種別ID
    // @return 挑戦回数
    static func getQuizTypesNumChallege (index : Int) -> Int {

        let ud = UserDefaults.standard
        if(ud.object(forKey: getUserDefaultsKeyQuizTypesNumChallenge(index: index)) == nil){
            
            saveQuizTypesNumChallenge(index: index, numChallenge: 0)
        }
        return ud.integer(forKey: getUserDefaultsKeyQuizTypesNumChallenge(index: index))
    }
    
    // 各クイズの挑戦回数を取得する
    // @return 挑戦回数
    static func getQuizTypesNumChalleges () -> [Int] {
        
        var numChallenges : [Int] = []
        
        for i in 0 ..< QUIZ_TYPES_NAMES.count {
            
            numChallenges.append(getQuizTypesNumChallege(index: i))
        }
        
        return numChallenges
    }
    
    // クイズの挑戦回数を保存する
    // @param index クイズ種別ID
    // @param numChallenge 挑戦回数
    static func saveQuizTypesNumChallenge (index : Int, numChallenge : Int) {
        
        let ud = UserDefaults.standard
        ud.set(numChallenge, forKey: getUserDefaultsKeyQuizTypesNumChallenge(index: index))
        
        ud.synchronize()
    }
    
    // 各クイズの挑戦回数を削除する
    // @param index クイズ種別ID
    static func removeQuizTypesNumChallenge (index : Int) {
        
        let ud = UserDefaults.standard
        ud.removeObject(forKey: getUserDefaultsKeyQuizTypesNumChallenge(index: index))
    }
    
    // 各クイズの挑戦回数を削除する
    static func removeQuizTypesNumChallenges () {
        
        for i in 0 ..< QUIZ_TYPES_NAMES.count {
            
            removeQuizTypesNumChallenge(index: i)
        }
    }
    
    // 現在のランクを計算する
    // @return 現在のランク
    static func getUserRank () -> Int {
        
        var rank : Int = PROFILE_RANKS_ID_AMATEUR
        
        for i in 0 ..< QUIZ_TYPES_NAMES.count {
            
            if(!getQuizTypesIsClear(index: i)){

                break
            }
            rank = i + 1
        }
        return rank
    }
    
    // 現在のランク名を取得する
    // @return 現在のランク名
    static func getUserRankName () -> String {
        
        return PROFILE_RANKS_NAMES[getUserRank()]
    }
    
    // 現在のランク説明を取得する
    // @return 現在のランク説明
    static func getUserRankExplanation () -> String {
        
        return PROFILE_RANKS_EXPLANATIONS[getUserRank()]
    }
    
    // クイズの挑戦可能有無を取得する
    // @param index クイズ種別ID
    // @return 挑戦可能有無(true, false)
    static func getQuizTypesIsChallengable (index : Int) -> Bool {
        
        // 各クイズのクリア有無を取得する
        var isCleares = getQuizTypesIsCleares()
        
        // 最初のクイズは条件なく挑戦可能とする
        if index == 0 {
            return true
        }
        
        // それより前のクイズを全てクリアしているかチェックする
        var tmpChallengableFlag : Bool = true
        for i in 0 ..< index {
            
            if(!isCleares[i]){
                
                tmpChallengableFlag = false
                break
            }
        }
        return tmpChallengableFlag
    }
    
    // 各クイズの挑戦可能有無を取得する
    // @return [クイズ種別0の挑戦可能有無（true,false）, ... , クイズnの挑戦可能有無]
    static func getQuizTypesIsChallengables () -> [Bool] {
        
        var isChallengables : [Bool] = []

        for i in 0 ..< QUIZ_TYPES_NAMES.count {
            
            isChallengables.append(getQuizTypesIsChallengable(index: i))
        }
        return isChallengables
    }
    
    // UserDefaultsの変音記号種別のキー
    static let USERDEFAULTS_KEY_MUSIC_NOTE_ACCIDENTAL_ID : String = "music_note_accidental_id"
    
    // ユーザ設定の変音記号IDを取得する
    // @return 変音記号ID
    static func getMusicNoteAccidentalId () -> Int {
        
        let ud = UserDefaults.standard
        if(ud.object(forKey: USERDEFAULTS_KEY_MUSIC_NOTE_ACCIDENTAL_ID) == nil){
            
            saveMusicNoteAccidentalId(accidentalId: KB.MUSIC_NOTE_ACCIDENTAL_ID_SHARP)
        }

        var accidentalId : Int = ud.integer(forKey: USERDEFAULTS_KEY_MUSIC_NOTE_ACCIDENTAL_ID)

        // ♯と♭以外の場合、♯をデフォルトとする
        if(accidentalId != MUSIC_NOTE_ACCIDENTAL_ID_SHARP && accidentalId != MUSIC_NOTE_ACCIDENTAL_ID_FLAT){
            
            accidentalId = MUSIC_NOTE_ACCIDENTAL_ID_SHARP
            saveMusicNoteAccidentalId(accidentalId: accidentalId)
        }
        return accidentalId
    }
    
    // ユーザ設定の変音記号IDを保存する
    // @param accidentalId 変音記号ID
    static func saveMusicNoteAccidentalId (accidentalId : Int) {
        
        let ud = UserDefaults.standard
        ud.set(accidentalId, forKey: USERDEFAULTS_KEY_MUSIC_NOTE_ACCIDENTAL_ID)
        
        ud.synchronize()
    }
    
    // ユーザ設定の変音記号IDを削除する
    static func removeMusicNoteAccidentalId () {
        
        let ud = UserDefaults.standard
        ud.removeObject(forKey: USERDEFAULTS_KEY_MUSIC_NOTE_ACCIDENTAL_ID)
    }
    
    // UserDefaultsの各弦の音階値のキー
    static let USERDEFAULTS_KEY_MUSIC_GUITAR_STRINGS_BASE_TONE = "music_guitar_string_id"
    
    // ユーザ設定の各弦の音階値のキーを取得する
    // @param index 弦ID
    // @return キー
    static func getUserDefaultsMusicGuitarStringsBaseTone (index : Int) -> String {

        return USERDEFAULTS_KEY_MUSIC_GUITAR_STRINGS_BASE_TONE + "_" + String(index)
    }
    
    // 各弦の音階値を取得する
    // @param index 弦ID
    // @return 音階値
    static func getMusicGuitarStringsBaseTone (index : Int) -> Int {
        
        let ud = UserDefaults.standard;
        if(ud.object(forKey: getUserDefaultsMusicGuitarStringsBaseTone(index: index)) == nil){
            
            saveMusicGuitarStringsBaseTone(index: index,
                tone: KB.MUSIC_GUITAR_STRINGS_DEFAULT_BASE_TONES[index])
        }
        return ud.integer(forKey: getUserDefaultsMusicGuitarStringsBaseTone(index: index))
    }
    
    // 各弦の音階値を取得する
    // @returm [音階値]
    static func getMusicGuitarStringsBaseTones () -> [Int] {
        
        var tmpTones : [Int] = []
        
        for i in 0 ..< MUSIC_GUITAR_STRINGS_DEFAULT_BASE_TONES.count {
            
            tmpTones.append(getMusicGuitarStringsBaseTone(index: i))
        }        
        return tmpTones
    }
    
    // 各弦の音階値を保存する
    // @param index 弦ID
    // @param tone 音階値
    static func saveMusicGuitarStringsBaseTone (index : Int, tone : Int) {
        
        let ud = UserDefaults.standard
        ud.set(tone, forKey: getUserDefaultsMusicGuitarStringsBaseTone(index: index))
        
        ud.synchronize()
    }
    
    // 各弦の音階値を削除する
    // @param index 弦ID
    static func removeMusicGuitarStringsBaseTone (index : Int) {
        
        let ud = UserDefaults.standard
        ud.removeObject(forKey: getUserDefaultsMusicGuitarStringsBaseTone(index: index))
    }
    
    // 各弦の音階値を削除する
    static func removeMusicGuitarStringsBaseTones () {
        
        for i in 0 ..< MUSIC_GUITAR_STRINGS_DEFAULT_BASE_TONES.count {
            
            removeMusicGuitarStringsBaseTone(index: i)
        }
    }
    
    // UserDefaultのデータを全消去する
    static func clearUserDefaultsData () {
        
        removeQuizTypesIsCleares()
        removeQuizTypesBestScoreRates()
        removeQuizTypesBestTimeSecs()
        removeQuizTypesBestDateTimes()
        removeQuizTypesNumChallenges()
        removeMusicNoteAccidentalId()
        removeMusicGuitarStringsBaseTones()
    }
}

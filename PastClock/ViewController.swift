//
//  ViewController.swift
//  PastClock
//
//  Created by Kenta Taki on 2017/06/22.
//  Copyright © 2017年 com.takiken. All rights reserved.
//

import UIKit
import ChameleonFramework


class ViewController: UIViewController {
    
    @IBOutlet weak var pieChartView: PieChartView!
    @IBOutlet weak var pieChartView2: PieChartView2!
    
    @IBOutlet weak var beaconPlace: UILabel!
    
    
    
    let beaconFileController = BeaconManager()
    var fileName = ""
    
    //csvファイルの中身を格納したファイル
    var dataList:[String] = []
    //dataListの中身を時間とBeaconIdに分解した配列
    var unitList:[String] = []
    
    var segments = [Segment]()
    var segments2 = [Segment2]()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        // タイトルをセット
        self.navigationItem.title = "today"
        
        // フォント種サイズ指定
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Baskerville", size: 30)!]
        
       
        getCsvData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getCsvData() {
    //csvの中身を取り出してListに格納する関数
    
        //BeaconManagerクラスで取得したパス
        
        //csvデータの解析処理
        do {
            
            let csvDate = DateFormatter()
            csvDate.dateFormat = "yyyyMMdd"
            let now = Date()
            
            fileName = csvDate.string(from: now) + ".csv"

            
            //取り出すファイルのパス
            let csvPath = NSHomeDirectory() + "/Documents/" + fileName
            
            let csvDatafromFile = try String(contentsOfFile:csvPath, encoding:String.Encoding.utf8)
            
            //csvファイルの中身を改行区切りで、dataLIstに格納
            dataList = csvDatafromFile.components(separatedBy: "\n")
        }catch {
            print(error)
        }
        //print(dataList)
        
        createPie()
        //print(BeaconIdList)
        
        beaconPlace.text = dataList.last!

        
    }
    
    //DataListから取り出して時刻とBeaconIDを１セットで分解して、角度と色を決定させる関数
    func createPie() {
        
        let numberOfList = dataList.count
        var unitString = ""
        
        for i in 0..<numberOfList{
            
            //午前中だけ
            
            unitString = dataList[i]
            unitList = unitString.components(separatedBy: ",")
            //print(unitList)
                
            //unitListの1列目(時間)をDouble型に直して角度を決定
            let seconds = Double(unitList[0])!
            
            let minutes = floor(seconds / 60)
            //午前中の場合

            if minutes <= 720 {
                
                let Angle = minutes / 720 * 360
            
                //unitListの２列目(BeaconId)をInt型に直して色を決定
                let value = Int(unitList[1])
                //基本色を白に
                var Color:UIColor = UIColor.black
                var beaconId = 0
                //エラー処理
                if value != nil{
                    beaconId = value!
                }
                //BeaconIdを色に振り分け
                if beaconId == 1{   //食堂
                    Color = UIColor.flatOrangeDark
                    
                }
                if beaconId == 2{   //コンビニ
                    
                    Color = UIColor.flatYellowDark
                }
                if beaconId == 3{   //バスケコート
                    
                    Color = UIColor.flatMaroon
                }
                if beaconId == 4{   //階段
                    Color = UIColor.flatSand
                }
                if beaconId == 5{   //情報入り口
                    
                    Color = UIColor.flatRed
                }
                if beaconId == 6{   //ジム
                    
                    Color = UIColor.flatPink
                }
                if beaconId == 7{   //ユビ研学生室
                    Color = UIColor.flatWatermelon
                }
                if beaconId == 8{   //L1
                    
                    Color = UIColor.flatSkyBlueDark
                }
                if beaconId == 9{   //L2
                    
                    Color = UIColor.flatBlueDark
                }
                if beaconId == 10{  //L3
                    
                    Color = UIColor.flatPurpleDark
                }
                if beaconId == 11{  //事務室
                    
                    Color = UIColor.flatPlum
                }
                if beaconId == 12{  //食堂2
                    
                    Color = UIColor.flatOrangeDark
                }
                if beaconId == 13{  //学生寮
                    
                    Color = UIColor.flatPowderBlue
                }
                if beaconId == 14{  //林研学生室
                    
                    Color = UIColor.flatWatermelonDark
                }
                if beaconId == 15{  //林研ミーティング室
                    
                    Color = UIColor.flatMintDark
                }
                if beaconId == 16{  //林研トイレ
                    
                    Color = UIColor.flatPowderBlueDark
                }
                if beaconId == 17{  //タバコ
                    
                    Color = UIColor.flatLime
                }
                if beaconId == 18{  //ユビ研トイレ
                    
                    Color = UIColor.flatPowderBlue
                }
                if beaconId == 19{  //エレベータ
                    
                    Color = UIColor.flatCoffee
                }
                if beaconId == 20{  //ユビ研ミーティング室
                    
                    Color = UIColor.flatMint
                }

            
                //print("am" + String(Angle) + String(describing: Color))
                segments.append(Segment(color: Color, angle: CGFloat(Angle)))
                
                
            
            }
                
            //午後から
            else{
                
                let Angle = (minutes - 720) / 720 * 360
                
                
                let value = Int(unitList[1])
                var Color:UIColor = UIColor.black
                var beaconId = 0
                
                if value != nil{
                    beaconId = value!
                }
                
                if beaconId == 1{   //食堂
                    Color = UIColor.flatOrangeDark
                    
                }
                if beaconId == 2{   //コンビニ
                    
                    Color = UIColor.flatYellowDark
                }
                if beaconId == 3{   //バスケコート
                    
                    Color = UIColor.flatMaroon
                }
                if beaconId == 4{   //階段
                    Color = UIColor.flatSand
                }
                if beaconId == 5{   //情報入り口
                    
                    Color = UIColor.flatRed
                }
                if beaconId == 6{   //ジム
                    
                    Color = UIColor.flatPink
                }
                if beaconId == 7{   //ユビ研学生室
                    Color = UIColor.flatWatermelon
                }
                if beaconId == 8{   //L1
                    
                    Color = UIColor.flatSkyBlueDark
                }
                if beaconId == 9{   //L2
                    
                    Color = UIColor.flatBlueDark
                }
                if beaconId == 10{  //L3
                    
                    Color = UIColor.flatPurpleDark
                }
                if beaconId == 11{  //事務室
                    
                    Color = UIColor.flatPlum
                }
                if beaconId == 12{  //食堂2
                    
                    Color = UIColor.flatOrangeDark
                }
                if beaconId == 13{  //学生寮
                    
                    Color = UIColor.flatPowderBlue
                }
                if beaconId == 14{  //林研学生室
                    
                    Color = UIColor.flatWatermelonDark
                }
                if beaconId == 15{  //林研ミーティング室
                    
                    Color = UIColor.flatMintDark
                }
                if beaconId == 16{  //林研トイレ
                    
                    Color = UIColor.flatPowderBlueDark
                }
                if beaconId == 17{  //タバコ
                    
                    Color = UIColor.flatLime
                }
                if beaconId == 18{  //ユビ研トイレ
                    
                    Color = UIColor.flatPowderBlue
                }
                if beaconId == 19{  //エレベータ
                    
                    Color = UIColor.flatCoffee
                }
                if beaconId == 20{  //ユビ研ミーティング室
                    
                    Color = UIColor.flatMint
                }

            //print("pm" + String(Angle) + String(describing: Color))
            segments2.append(Segment2(color: Color, angle: CGFloat(Angle)))
            
            
            }

        }
        //pieChartViewに追加する
        
        
        self.pieChartView.segments = segments
        self.pieChartView2.segments2 = segments2
        
        //リストを一旦空にする
        segments.removeAll()
        segments2.removeAll()
    
    }
    
    @IBAction func upload(_ sender: Any) {
        
        getCsvData()
        
    }
    
    func removeList() {
        
    }
    
}

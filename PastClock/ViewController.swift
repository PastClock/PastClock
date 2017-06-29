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
            let minutes = Double(unitList[0])!
            
            //午前中の場合
            if minutes <= 720 {
                
                let Angle = minutes / 720 * 360
            
                //unitListの２列目(BeaconId)をInt型に直して色を決定
                let value = Int(unitList[1])
                //基本色を白に
                var Color:UIColor = UIColor.white
                var beaconId = 0
                //エラー処理
                if value != nil{
                    beaconId = value!
                }
                //BeaconIdを色に振り分け
                if beaconId == 1{
                    Color = UIColor.flatRed
                }
                if beaconId == 2{
                    Color = UIColor.flatOrange
                }
                if beaconId == 3{
                    Color = UIColor.flatYellow
                }
                if beaconId == 4{
                    Color = UIColor.flatSand
                }
                if beaconId == 5{
                    Color = UIColor.flatNavyBlue
                }
                if beaconId == 6{
                    Color = UIColor.flatMagenta
                }
                if beaconId == 7{
                    Color = UIColor.flatWatermelon
                }
                if beaconId == 8{
                    Color = UIColor.flatSkyBlue
                }
                if beaconId == 9{
                    Color = UIColor.flatGreen
                }
                if beaconId == 10{
                    Color = UIColor.flatMint
                }
                if beaconId == 11{
                    Color = UIColor.flatForestGreen
                }
                if beaconId == 12{
                    Color = UIColor.flatPurple
                }
                if beaconId == 13{
                    Color = UIColor.flatBrown
                }
                if beaconId == 14{
                    Color = UIColor.flatPlum
                }
                if beaconId == 15{
                    Color = UIColor.flatTeal
                }
                if beaconId == 16{
                    Color = UIColor.flatLime
                }
                if beaconId == 17{
                    Color = UIColor.flatPink
                }
                if beaconId == 18{
                    Color = UIColor.flatCoffee
                }
                if beaconId == 19{
                    Color = UIColor.flatPowderBlue
                }
                if beaconId == 20{
                    Color = UIColor.flatBlue
                }

            
                //print("am" + String(Angle) + String(describing: Color))
                segments.append(Segment(color: Color, angle: CGFloat(Angle)))
                
                
            
            }
                
            //午後から
            else{
                
                let Angle = (minutes - 720) / 720 * 360
                
                
                let value = Int(unitList[1])
                var Color:UIColor = UIColor.white
                var beaconId = 0
                
                if value != nil{
                    beaconId = value!
                }
                
                if beaconId == 1{
                    Color = UIColor.flatRed
                }
                if beaconId == 2{
                    Color = UIColor.flatOrange
                }
                if beaconId == 3{
                    Color = UIColor.flatYellow
                }
                if beaconId == 4{
                    Color = UIColor.flatSand
                }
                if beaconId == 5{
                    Color = UIColor.flatNavyBlue
                }
                if beaconId == 6{
                    Color = UIColor.flatMagenta
                }
                if beaconId == 7{
                    Color = UIColor.flatWatermelon
                }
                if beaconId == 8{
                    Color = UIColor.flatSkyBlue
                }
                if beaconId == 9{
                    Color = UIColor.flatGreen
                }
                if beaconId == 10{
                    Color = UIColor.flatMint
                }
                if beaconId == 11{
                    Color = UIColor.flatForestGreen
                }
                if beaconId == 12{
                    Color = UIColor.flatPurple
                }
                if beaconId == 13{
                    Color = UIColor.flatBrown
                }
                if beaconId == 14{
                    Color = UIColor.flatPlum
                }
                if beaconId == 15{
                    Color = UIColor.flatTeal
                }
                if beaconId == 16{
                    Color = UIColor.flatLime
                }
                if beaconId == 17{
                    Color = UIColor.flatPink
                }
                if beaconId == 18{
                    Color = UIColor.flatCoffee
                }
                if beaconId == 19{
                    Color = UIColor.flatPowderBlue
                }
                if beaconId == 20{
                    Color = UIColor.flatBlue
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

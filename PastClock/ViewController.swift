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
    
    let beaconFileController = BeaconManager()
    var fileName = ""
    
    var dataList:[String] = []
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
        
        
        
    }
    
    //時刻とBeaconIDを１セットで分解して、角度と色を決定させる関数
    func createPie() {
        
        let numberOfList = dataList.count
        var unitString = ""
        
        for i in 0..<numberOfList{
            
            //午前中だけ
            if i <= 720 {
            
                unitString = dataList[i]
                unitList = unitString.components(separatedBy: ",")
                //print(unitList)
            
                let i = Double(unitList[0])!
                let Angle = i / 720 * 360
            
            
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

            
                //print(Color)
                segments.append(Segment(color: Color, angle: CGFloat(Angle)))
                
            //午後から
            }
            else{
                unitString = dataList[i]
                unitList = unitString.components(separatedBy: ",")
                //print(unitList)
                
                let i = Double(unitList[0])!
                let Angle = (i - 720) / 720 * 360
                
                
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

            segments2.append(Segment2(color: Color, angle: CGFloat(Angle)))
            
            }

        }
        
        self.pieChartView.segments = segments
        self.pieChartView2.segments2 = segments2
    }
}

//
//  ViewController.swift
//  PastClock
//
//  Created by Kenta Taki on 2017/06/22.
//  Copyright © 2017年 com.takiken. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let beaconFileController = BeaconManager()
    var fileName = ""
    var dataList:[String] = []


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func getCsvData(_ sender: Any) {
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
            
            dataList = csvDatafromFile.components(separatedBy: "\n")
        }catch {
            print(error)
        }
        print(dataList)
        
    }



}


//
//  BeaconManager.swift
//  PastClock
//
//  Created by Kenta Taki on 2017/06/22.
//  Copyright © 2017年 com.takiken. All rights reserved.
//

import UIKit
import CoreLocation

struct BeaconID{
    let uuid: UUID
    
    init(uuid:UUID)
    {
        self.uuid = uuid
    }
    
    init(uuidString:String)
    {
        self.init(uuid:UUID(uuidString: uuidString)!)
    }
    
    var asString: String{
        get{
            return "\(uuid.uuidString)"
        }
    }
    
    //
    var asBeaconRegion: CLBeaconRegion{
        get{
            return CLBeaconRegion(proximityUUID: self.uuid, identifier: self.asString)
        }
    }
    
    var description: String{
        get{
            return self.asString
        }
    }
    
    var hasValue: Int{
        get{
            return self.asString.hashValue
        }
    }
}


class BeaconManager: NSObject,CLLocationManagerDelegate {
    
    //csvファイル名
    var csvFileName = ""
    var filePath = ""
    
    //書き込む内容
    var contents: String?
    
    
    //今検知しているbeacon
    var detectedBeacon = ""
    var timer: Timer!
    
    let locationManager = CLLocationManager()
    
    // ビーコンの基本情報設定 -- ここからのコードは触らなくてオッケー
    let uuid = "00000000-1234-1234-ABCD-123456789ABC"
    var MyBeaconRegion:BeaconID!
    var beaconUUID : UUID!
    var minorID = 0
    var majorID = 0
    var rssi = 0
    var proximity = ""
    var detectedBeacons = [CLBeacon]()
    //　ここまでが基本設定
    
    
    func runBeacon() {
        
        let locationManager = self.locationManager
        
        // Locationの設定
        locationManager.delegate = self
        
        // requestAlwaysAuthorazation = 常にバックグラウンドでデータを取る
        locationManager.requestAlwaysAuthorization()
        
        // allowsBackgroundLocationUpdates =　バックグラウンドでの記録も行う
        locationManager.allowsBackgroundLocationUpdates = true
        
        // 使うビーコンを基本情報を設定する
        MyBeaconRegion = BeaconID(uuidString: uuid)
        
        print("let's start forward monitoring!")
        
        startMonitoringItem(item: MyBeaconRegion)
    }
    
    
    
    
    // filteredBeaconは知らないビーコンを削除する関数
    func filteredBeacons(_ beacons: [CLBeacon]) -> [CLBeacon]
    {
        let knownBeacons = beacons.filter{
            // 分からないビーコンを削除
            $0.proximity != CLProximity.unknown
        }
        
        // knownBeacons = 全ての検知したビーコン
        var filteredBeacons =  knownBeacons
        var loopup = Set<String>()
        for index in 0..<knownBeacons.count
        {
            let currentBeacon = knownBeacons[index]
            let identifier = "\(currentBeacon.major)/\(currentBeacon.minor)"
            
            // 同じビーコンを（重複しないように）削除
            if loopup.contains(identifier)
            {
                filteredBeacons.remove(at: index)
            }
            else
            {
                loopup.insert(identifier)
            }
        }
        
        return filteredBeacons
    }
    
    
    // どのビーコンを検知するのかを指定する関数（ビーコンマネージャーで設定したビーコン情報に基づく）
    func beaconRegionWithItem(item: BeaconID) -> CLBeaconRegion
    {
        let beaconRegion = CLBeaconRegion(proximityUUID: item.uuid, identifier: item.asString)
        return beaconRegion
    }
    
    
    // Scanを開始する関数
    func startMonitoringItem(item: BeaconID)
    {
        let beaconRegion = beaconRegionWithItem(item: item)
        locationManager.startMonitoring(for: beaconRegion)
        locationManager.startRangingBeacons(in: beaconRegion)
    }
    
    // Scanを停止する関数
    func stopMonitoringItem(item: BeaconID)
    {
        let beaconRegion = beaconRegionWithItem(item: item)
        locationManager.stopMonitoring(for: beaconRegion)
    }
    
    // エラーが出た時の対応をする関数(デバックするようにprintするとこ）(Locationが取れない）
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("location manager failed:\(error)")
    }
    
    // エラーが出た時の対応をする関数(デバックするようにprintするとこ）（Monitoringできない）
    func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error) {
        print("Monitoring Failed : \(error)")
    }
    
    // エラーが出た時の対応をする関数(デバックするようにprintするとこ）(Rangeが取れない)
    func locationManager(_ manager: CLLocationManager, rangingBeaconsDidFailFor region: CLBeaconRegion, withError error: Error) {
        print("Ranging Beacons Failed :\(error)")
    }
    
    // エラーが出た時の対応をする関数(デバックするようにprintするとこ）(更新が出来なかった時に出る）
    func locationManager(_ manager: CLLocationManager, didFinishDeferredUpdatesWithError error: Error?)
    {
        if error != nil
        {
            print("We didn't finish the update successfully: \(String(describing: error))")
        }
        else{
            print("We didn't finish the update successfully with unknown error")
        }
    }
    
    
    //　ビーコンを検知した時にビーコンの情報の扱い方を決める関数
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        
        DispatchQueue.main.async {
            () -> Void in
            let filteredBeacons = self.filteredBeacons(beacons)
            
            if filteredBeacons.isEmpty
            {
                self.detectedBeacon = String(0)
                print("No beacons found nearby")
            }
            else{
                let beaconsString : String
                
                // ここでビーコンを検知しているのでここに保存するコードを書く。
                // 例えば、下のプリント部分で最も近いビーコンを表示している。
                print(filteredBeacons[0].major)
                print(filteredBeacons[0].minor)
                
                
                if(filteredBeacons[0].rssi > -70)
                {
                print("We found one!")
                self.detectedBeacon = String(describing: filteredBeacons[0].major)
                }
                
                if filteredBeacons.count > 1
                {
                    beaconsString = "beacons"
                }
                else
                {
                    beaconsString = "beacon"
                }
                print("Found \(filteredBeacons.count) \(beaconsString).")
                
                self.writeContents()
                
                //self.detectedBeacon = "現在" + String(describing: filteredBeacons[0].major)
                
                //self.timer = Timer.scheduledTimer(timeInterval: 30.0, target: self, selector: #selector(self.writeContents), userInfo: nil, repeats: true)
            
            }
        }
    }
    
    //  Locationを許可を確認する時の関数
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways
        {
            locationManager.startUpdatingLocation()
        }
        else
        {
            // Location情報の許可を得てない場合にprint (デバック用）
            print("This app needs the Location and it can't be used when the location service is Off")
        }
    }
    
    // 検出範囲に入った時の関数
    // ここの関数をいじれば検出範囲に入った時どうするっていう機能をつけられる。
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {

        print("Hi,there,welcome to my world!")
    }
    
    // 検出範囲から出た時の関数
    // ここの関数をいじれば検出範囲を出た時にどうするっていう機能をつけられる。
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("Goodbye, hope to see you again!")
    }
    
    

    
    //csvファイルの日付
    func dateForCsv(){
        let csvDate = DateFormatter()
        csvDate.dateFormat = "yyyyMMdd"
        let now = Date()
        //日付を元にファイル名作成
        csvFileName = csvDate.string(from: now) + ".csv"
    }

    
    //Sandboxにファイルパスを作成
    func makeFilePath(){
        
        dateForCsv()
        //ファイルのパスを作成
        filePath = NSHomeDirectory() + "/Documents/" + csvFileName
        
        print("書き込むファイルのパス: \(filePath)")
        
        //時間取得
        let formatterH = DateFormatter()
        formatterH.dateFormat = "HH"
        let hour = Date()
        //分取得
        let formatterM = DateFormatter()
        formatterM.dateFormat = "mm"
        let minutes = Date()
        //秒取得
        let formatterS = DateFormatter()
        formatterS.dateFormat = "ss"
        let seconds = Date()
        
        
        //時間を秒表示
        let time = Int(formatterH.string(from: hour))! * 3600 + Int(formatterM.string(from: minutes))! * 60 + Int(formatterS.string(from: seconds))!

        
        let initialtext = String(time) + "," + "0"
        
        do {
            try initialtext.write(toFile: filePath, atomically: true, encoding: String.Encoding.utf8)
            
        } catch let error as NSError {
            print("failed to write: \(error)")
            
        }

    }
    
    
    //ファイルの存在確認後、なければファイルを作成
    //これもdelegateで呼び出される
    func createFileAfterCheck(){
        
        dateForCsv()
        
        let DocumentFilePath: String = NSHomeDirectory() + "/Documents/"
        
        let path = NSString(string: DocumentFilePath + csvFileName)
        
        let checkValidation = FileManager.default
        
        if (checkValidation.fileExists(atPath: path as String)){
            print("ファイルあり、追記開始");
        }else{
            print("ファイルが存在しない、新規ファイル作成")
            makeFilePath()
        }
        return
    }
    
    //タイマーで1分毎に処理
    //func timerForWrite() {
     //   timer = Timer.scheduledTimer(timeInterval: 60.0, target: self, selector: #selector(self.writeContents), userInfo: nil, repeats: true)
    //}
    
    //csvファイルに書き込む処理
    func writeContents() {
        //時間取得
        let formatterH = DateFormatter()
        formatterH.dateFormat = "HH"
        let hour = Date()
        //分取得
        let formatterM = DateFormatter()
        formatterM.dateFormat = "mm"
        let minutes = Date()
        //秒取得
        let formatterS = DateFormatter()
        formatterS.dateFormat = "ss"
        let seconds = Date()
        
        
        //時間を秒表示
        let time = Int(formatterH.string(from: hour))! * 3600 + Int(formatterM.string(from: minutes))! * 60 + Int(formatterS.string(from: seconds))!
        //保存するデータ
        let csvData = String(time) + "," + detectedBeacon
        
        contents = csvData
        print("csvファイルに保存" + contents!)
        
        //追記するファイルのURLを取得
        dateForCsv()
        let DocumentFilePath: String = NSHomeDirectory() + "/Documents/"
        
        if let documentDirectoryFileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last {
            let targetPath = documentDirectoryFileURL.appendingPathComponent(csvFileName)
            let path = NSString(string: DocumentFilePath + csvFileName)
            let checkValidation = FileManager.default
            
            //日付変更時の対策で、追記する際にファイルがなければ新しいファイルを作成
            if (checkValidation.fileExists(atPath: path as String)){
                appendCsv(fileURL: targetPath);
                print("ファイルあり、追記開始")
            }else{
                print("ファイルナッシング")
                makeFilePath()
            }
        }
    }
    
    //改行してファイルの最後に書き込む処理
    func appendCsv(fileURL: URL) {
        do {
            let fileHandle = try FileHandle(forWritingTo: fileURL)
            
            let stringToWrite = "\n" + contents!
            
            fileHandle.seekToEndOfFile()
            fileHandle.write(stringToWrite.data(using: String.Encoding.utf8)!)
            
        } catch let error as NSError {
            print("failed to append: \(error)")
        }

    
    }
    var List1:[Int] = []
    
    
}

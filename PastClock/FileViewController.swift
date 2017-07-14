//
//  FileViewController.swift
//  PastClock
//
//  Created by Kenta Taki on 2017/06/29.
//  Copyright © 2017年 com.takiken. All rights reserved.
//

import UIKit

class FileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let dateArray = [0,24,48,72,96,120,144]
    var csvFiles:[String] = []
    
    //csvの中身
    var csvData:[String] = []
    
    /// セルの個数を指定するデリゲートメソッド（必須）
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return csvFiles.count
    }
    
    /// セルに値を設定するデータソースメソッド（必須）
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // セルを取得する
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        
        // セルに表示する値を設定する
        cell.textLabel!.text = csvFiles[indexPath.row]
        
        return cell
        
    }
    
    /// セルが選択された時に呼ばれるデリゲートメソッド
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("セル番号：\(indexPath.row) セルの内容：\(csvFiles[indexPath.row])")
        
        do {
            //取り出すファイルのパス
            let csvPath = NSHomeDirectory() + "/Documents/" + csvFiles[indexPath.row]
            
            let csvDatafromFile = try String(contentsOfFile:csvPath, encoding:String.Encoding.utf8)
            
            //print(csvDatafromFile)
            
            //csvファイルの中身を改行区切りで、csvDataに格納
            csvData = csvDatafromFile.components(separatedBy: "\n")
            
            let documentInteraction = UIDocumentInteractionController(url: URL(fileURLWithPath: csvPath))
            
            if !documentInteraction.presentOpenInMenu(from: self.view.frame, in: self.view, animated: true) {
                // 送信できるアプリが見つからなかった時の処理
                let alert = UIAlertController(title: "送信失敗", message: "ファイルを送れるアプリが見つかりません", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            
            print(csvData)
            
        }catch {
            print(error)

        
        
        }
        
    }
    
    //Viewが呼ばれるたびに一週間分のfie文字列作成
    func getDate() {
        
        let fmt = DateFormatter()
        fmt.dateFormat = "yyyyMMdd"
        
        for i in dateArray{
            let date = Date(timeIntervalSinceNow:TimeInterval(-60*60*i))
            
            let csvFileName = fmt.string(from: date) + ".csv"
            csvFiles.append(csvFileName)
            
        }
        
        print(csvFiles)
        
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getDate()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

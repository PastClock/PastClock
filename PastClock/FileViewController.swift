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
    }
    
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

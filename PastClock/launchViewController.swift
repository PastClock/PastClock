//
//  launchViewController.swift
//  PastClock
//
//  Created by Kenta Taki on 2017/07/13.
//  Copyright © 2017年 com.takiken. All rights reserved.
//

import UIKit
import AVFoundation

class launchViewController: UIViewController {
    
    var audioPlayerInstance : AVAudioPlayer! = nil  // 再生するサウンドのインスタンス

    @IBOutlet weak var imageClock: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //最初にアニメ終了後に表示するimageを設定しておく
        imageClock.image = UIImage(named: "18clock")
        //アニメのコマ設定
        let imageArray:[UIImage] = [
            UIImage(named: "0clock")!,
            UIImage(named: "1clock")!,
            UIImage(named: "2clock")!,
            UIImage(named: "3clock")!,
            UIImage(named: "4clock")!,
            UIImage(named: "5clock")!,
            UIImage(named: "6clock")!,
            UIImage(named: "7clock")!,
            UIImage(named: "8clock")!,
            UIImage(named: "9clock")!,
            UIImage(named: "10clock")!,
            UIImage(named: "11clock")!,
            UIImage(named: "12clock")!,
            UIImage(named: "13clock")!,
            UIImage(named: "14clock")!,
            UIImage(named: "15clock")!,
            UIImage(named: "16clock")!,
            UIImage(named: "17clock")!,
            UIImage(named: "18clock")!,
            
        ]
        imageClock.animationImages = imageArray
        imageClock.animationDuration = 4.0
        imageClock.animationRepeatCount = 1
        imageClock.startAnimating()

        // サウンドファイルのパスを生成
        let soundFilePath = Bundle.main.path(forResource: "clock", ofType: "mp3")!
        let sound:URL = URL(fileURLWithPath: soundFilePath)
        // AVAudioPlayerのインスタンスを作成
        do {
            audioPlayerInstance = try AVAudioPlayer(contentsOf: sound, fileTypeHint:nil)
        } catch {
            print("AVAudioPlayerインスタンス作成失敗")
        }
        // バッファに保持していつでも再生できるようにする
        audioPlayerInstance.prepareToPlay()
        
        audioPlayerInstance.enableRate = true
        
        audioPlayerInstance.rate = 2.0

        audioPlayerInstance.play()
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

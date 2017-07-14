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
    
    @IBAction func startbutton(_ sender: Any) {
        audioPlayerInstance.stop()
    }

    @IBOutlet weak var imageClock: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //最初にアニメ終了後に表示するimageを設定しておく
        imageClock.image = UIImage(named: "clockimage.018")
        //アニメのコマ設定
        let imageArray:[UIImage] = [
            UIImage(named: "clockimage.001")!,
            UIImage(named: "clockimage.002")!,
            UIImage(named: "clockimage.003")!,
            UIImage(named: "clockimage.004")!,
            UIImage(named: "clockimage.005")!,
            UIImage(named: "clockimage.006")!,
            UIImage(named: "clockimage.007")!,
            UIImage(named: "clockimage.008")!,
            UIImage(named: "clockimage.009")!,
            UIImage(named: "clockimage.010")!,
            UIImage(named: "clockimage.011")!,
            UIImage(named: "clockimage.012")!,
            UIImage(named: "clockimage.013")!,
            UIImage(named: "clockimage.014")!,
            UIImage(named: "clockimage.015")!,
            UIImage(named: "clockimage.016")!,
            UIImage(named: "clockimage.017")!,
            UIImage(named: "clockimage.018")!,
            
            
            
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

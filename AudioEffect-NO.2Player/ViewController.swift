//
//  ViewController.swift
//  AudioEffect-NO.2Player
//
//  Created by Bruce on 16/6/6.
//  Copyright © 2016年 Ucai. All rights reserved.
//
import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    
    lazy var engine = AVAudioEngine()
    lazy var player = AVAudioPlayerNode()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        音频文件的路径
        let path = NSBundle.mainBundle().pathForResource("short", ofType: "mp3")
        
        let url = NSURL.init(string: path!)
//        创建音频文件对象
        let audioFile = try! AVAudioFile.init(forReading: url!)
//        将音频播放器节点 附着到音频引擎
        engine.attachNode(player)
//        设置音频播放器节点
        player.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        player.volume = 1.0
        
//        初始化并设置混响效果器节点
        let reverb = AVAudioUnitReverb()
        reverb.loadFactoryPreset(.MediumHall)
        reverb.wetDryMix = 80
        engine.attachNode(reverb)
        
//        音频引擎连接节点
        engine.connect(player, to: reverb, format: audioFile.processingFormat)
        engine.connect(reverb, to: engine.outputNode, format: audioFile.processingFormat)
    }
    
    @IBAction func playOrStop(sender: AnyObject) {
        try! engine.start()
        player.play()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


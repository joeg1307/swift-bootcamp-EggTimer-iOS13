//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    let eggTimes = ["Soft":1,"Hard":12,"Medium":7]
    var eggCountdown = 60
    var timer = Timer()
    var maxProgress = 100
    var player: AVAudioPlayer?
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBAction func hardnessSelected(_ sender: UIButton) {
        let hardness = sender.currentTitle!
        eggCountdown = toSeconds(minutes: eggTimes[hardness]!)
        timer.invalidate()
        progressBar.progress = 0.0
        self.maxProgress = eggCountdown
        
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target:self,selector: #selector(updateTimer),userInfo: nil, repeats: true)
    }
    func updateProgressBar(){
        let pg = Float(self.eggCountdown) / Float(self.maxProgress)
        let progress = (1.0-pg)
        self.progressBar.setProgress(progress, animated: true)
    }
    
    @objc func updateTimer(){
        if eggCountdown > 0{
            self.titleLabel.text = "\(self.eggCountdown) seconds."
            if eggCountdown % 5 == 0{
                updateProgressBar()
            }
            print ("\(self.eggCountdown) seconds. \(self.progressBar.progress)%")
            self.eggCountdown -= 1
        }else{
            timer.invalidate()
            self.titleLabel.text = "Done!"
            playSound()
        }
    }
    func toSeconds (minutes:Int)->Int{
       
        return minutes * 60
    }
    
    func playSound() {
        guard let path = Bundle.main.path(forResource: "alarm_sound", ofType:"mp3") else {
            return }
        let url = URL(fileURLWithPath: path)

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }

}

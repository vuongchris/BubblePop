//
//  GameViewController.swift
//  BubblePop
//
//  Created by Christopher Vuong on 6/4/2022.
//

import Foundation
import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var remainingTimeLabel: UILabel!
    @IBOutlet weak var currentScoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    var remainingTime = 60
    var timer = Timer()
    var numOfBubbles = 15
    var currentScore = 0
    var previousBubbleColor = "white"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        remainingTimeLabel.text = String(remainingTime)
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {
            timer in
            self.countingDown()
            self.generateBubble(bubbles: self.numOfBubbles)
        }
        
    }
    
    @objc func countingDown() {
        remainingTime -= 1
        remainingTimeLabel.text = String(remainingTime)
        
        if remainingTime == 0 {
            timer.invalidate()
            
            let vc = storyboard?.instantiateViewController(identifier: "HighScoreViewController") as! HighScoreViewController
            self.navigationController?.pushViewController(vc, animated: true)
            vc.navigationItem.setHidesBackButton(true, animated: true)
        }
    }
    
    @objc func generateBubble(bubbles: Int) {
        for _ in stride(from: 0, to: Int.random(in: 0...bubbles), by: 1) {
            let bubble = Bubble()
            bubble.animation()
            bubble.addTarget(self, action: #selector(bubblePressed), for: .touchUpInside)
            self.view.addSubview(bubble)
        }
    }
    
    @objc func removeRandomBubble() {
        
    }
    
    @objc func updateCurrentScore(_ sender: UIButton) {
        if sender.backgroundColor == .red {
            redBubbleScore(previousBubbleColor)
        } else if sender.backgroundColor == .magenta {
            magentaBubbleScore(previousBubbleColor)
        } else if sender.backgroundColor == .green {
            greenBubbleScore(previousBubbleColor)
        } else if sender.backgroundColor == .blue {
            blueBubbleScore(previousBubbleColor)
        } else if sender.backgroundColor == .black {
            blackBubbleScore(previousBubbleColor)
        }
        currentScoreLabel.text = String(currentScore)
    }
    
    @objc func redBubbleScore(_ previousColor: String) {
        if previousColor == "red" {
            currentScore += Int(round(1 * 1.5))
        } else {
            currentScore += 1
            previousBubbleColor = "red"
        }
    }
    
    @objc func magentaBubbleScore(_ previousColor: String) {
        if previousColor == "magenta" {
            currentScore += Int(round(2 * 1.5))
        } else {
            currentScore += 1
            previousBubbleColor = "magenta"
        }
    }
    
    @objc func greenBubbleScore(_ previousColor: String) {
        if previousColor == "green" {
            currentScore += Int(round(5 * 1.5))
        } else {
            currentScore += 1
            previousBubbleColor = "green"
        }
    }
    
    @objc func blueBubbleScore(_ previousColor: String) {
        if previousColor == "blue" {
            currentScore += Int(round(8 * 1.5))
        } else {
            currentScore += 1
            previousBubbleColor = "blue"
        }
    }
    
    @objc func blackBubbleScore(_ previousColor: String) {
        if previousColor == "black" {
            currentScore += Int(round(10 * 1.5))
        } else {
            currentScore += 1
            previousBubbleColor = "black"
        }
    }
    
    @IBAction func bubblePressed(_ sender: UIButton) {
        // remove pressed bubble from view
        sender.removeFromSuperview()
        updateCurrentScore(sender)
    }
    
}

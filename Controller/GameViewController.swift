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
        for _ in stride(from: 0, to: bubbles, by: 1) {
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
            currentScore += 1
        } else if sender.backgroundColor == .magenta {
            currentScore += 2
        } else if sender.backgroundColor == .green {
            currentScore += 5
        } else if sender.backgroundColor == .blue {
            currentScore += 8
        } else if sender.backgroundColor == .black {
            currentScore += 10
        }
        currentScoreLabel.text = String(currentScore)
    }
    
    @IBAction func bubblePressed(_ sender: UIButton) {
        // remove pressed bubble from view
        sender.removeFromSuperview()
        updateCurrentScore(sender)
    }
    
}

//
//  GameViewController.swift
//  BubblePop
//
//  Created by Christopher Vuong on 6/4/2022.
//

import Foundation
import UIKit
import SpriteKit

class GameViewController: UIViewController {

    @IBOutlet weak var remainingTimeLabel: UILabel!
    @IBOutlet weak var currentScoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    var name: String?
    var remainingTime = 60
    var timer = Timer()
    var numOfBubbles = 15
    var currentScore = 0
    var previousBubbleColor = "white"
    var currentBubblesOnScreen = 0
    var bubbleOverlap = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        remainingTimeLabel.text = String(remainingTime)
        highScoreLabel.text = highScoreValue()
        
        self.generateBubble(bubbles: self.numOfBubbles)
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {
            timer in
            self.countingDown()
            self.removeRandomBubbles(bubbles: self.numOfBubbles)
            self.generateBubble(bubbles: self.numOfBubbles)
        }
        
    }
    
    // Countdown timer and once the time runs out go to HighScoreViewController
    @objc func countingDown() {
        remainingTime -= 1
        remainingTimeLabel.text = String(remainingTime)
        
        if remainingTime == 0 {
            timer.invalidate()
            
            let vc = storyboard?.instantiateViewController(identifier: "HighScoreViewController") as! HighScoreViewController
            vc.currentGameScore = currentScore
            vc.currentPlayerName = name!
            vc.newScore = true
            self.navigationController?.pushViewController(vc, animated: true)
            vc.navigationItem.setHidesBackButton(true, animated: true)
            
        }
    }
    
    // Generates a random number of bubbles
    @objc func generateBubble(bubbles: Int) {
        for _ in stride(from: 1, through: Int.random(in: 2...bubbles), by: 1) {
            if currentBubblesOnScreen < numOfBubbles {
                let bubble = Bubble()
                var xPosition = CGFloat.random(in: 10...CGFloat(UIScreen.main.bounds.size.width * 0.8))
                var yPosition = CGFloat.random(in: 130...CGFloat(UIScreen.main.bounds.size.height * 0.9))
                bubbleOverlap = true
                while bubbleOverlap != false {
                    if ifOverlap(x: xPosition, y: yPosition) {
                        xPosition = CGFloat.random(in: 10...CGFloat(UIScreen.main.bounds.size.width * 0.7))
                        yPosition = CGFloat.random(in: 130...CGFloat(UIScreen.main.bounds.size.height * 0.8))
                        bubbleOverlap = true
                    } else {
                        bubbleOverlap = false
                    }
                }
                bubble.animation()
                bubble.addTarget(self, action: #selector(bubblePressed), for: .touchUpInside)
                bubble.frame = CGRect(x: xPosition, y: yPosition, width: 40, height: 40)
                bubble.layer.cornerRadius = 0.5 * bubble.bounds.size.width
                self.view.addSubview(bubble)
                currentBubblesOnScreen += 1
            } else {
                break
            }
        }
    }
    
    @objc func ifOverlap(x xPos: CGFloat, y yPos: CGFloat) -> Bool {
        for button in self.view.subviews {
            let buttonXLeftPosition: CGFloat = button.frame.origin.x
            let buttonXRightPosition: CGFloat = button.frame.origin.x + 40
            let buttonYTopPosition: CGFloat = button.frame.origin.y
            let buttonYBottomPosition: CGFloat = button.frame.origin.y + 40
            
            if (xPos >= buttonXLeftPosition - 40 && xPos <= buttonXRightPosition + 40) && (yPos >= buttonYTopPosition - 40 && yPos <= buttonYBottomPosition + 40) {
                return true
            }
        }
        return false
    }
    
    // Removes a random number of bubbles
    @objc func removeRandomBubbles(bubbles: Int) {
        let randomInt = Int.random(in: 0...bubbles)
        var cycleCount = 0
        for button in self.view.subviews {
            if cycleCount < randomInt {
                if button.isKind(of: UIButton.self) {
                    button.removeFromSuperview()
                    currentBubblesOnScreen -= 1
                }
            } else {
                break
            }
            cycleCount += 1
        }
    }
    
    // Checks what bubble was pressed by the user and updates the score
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
    
    // Adds red bubble score value to current game score
    @objc func redBubbleScore(_ previousColor: String) {
        if previousColor == "red" {
            currentScore += Int(round(1 * 1.5))
        } else {
            currentScore += 1
            previousBubbleColor = "red"
        }
    }
    
    // Adds magenta bubble score value to current game score
    @objc func magentaBubbleScore(_ previousColor: String) {
        if previousColor == "magenta" {
            currentScore += Int(round(2 * 1.5))
        } else {
            currentScore += 2
            previousBubbleColor = "magenta"
        }
    }
    
    // Adds green bubble score value to current game score
    @objc func greenBubbleScore(_ previousColor: String) {
        if previousColor == "green" {
            currentScore += Int(round(5 * 1.5))
        } else {
            currentScore += 5
            previousBubbleColor = "green"
        }
    }
    
    // Adds blue bubble score value to current game score
    @objc func blueBubbleScore(_ previousColor: String) {
        if previousColor == "blue" {
            currentScore += Int(round(8 * 1.5))
        } else {
            currentScore += 8
            previousBubbleColor = "blue"
        }
    }
    
    // Adds black bubble score value to current game score
    @objc func blackBubbleScore(_ previousColor: String) {
        if previousColor == "black" {
            currentScore += Int(round(10 * 1.5))
        } else {
            currentScore += 10
            previousBubbleColor = "black"
        }
    }
    
    // Removes bubble selected by the user and updates the score
    @IBAction func bubblePressed(_ sender: UIButton) {
        // remove pressed bubble from view
        sender.removeFromSuperview()
        updateCurrentScore(sender)
    }
    
    @objc func highScoreValue() -> String {
        let highScoreVC = HighScoreViewController()
        var array = highScoreVC.highScores
        
        array.sort {
            $0.score > $1.score
        }
        
        if array.count > 0 {
            return String(array[0].score)
        } else {
            return "0"
        }
    }
}

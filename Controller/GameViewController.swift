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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        remainingTimeLabel.text = String(remainingTime)
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {
            timer in
            self.generateBubble()
            self.countingDown()
        }
        
    }
    
    @objc func countingDown() {
        remainingTime -= 1
        remainingTimeLabel.text = String(remainingTime)
        
        if remainingTime == 0 {
            timer.invalidate()
            
            let vc = storyboard?.instantiateViewController(identifier: "HighScoreViewController") as! HighScoreViewController
            self.navigationController?.pushViewController(vc, animated: true)
            // vc.navigationItem.setHidesBackButton(true, animated: true)
        }
    }
    
    @objc func generateBubble() {
        let bubble = Bubble()
        bubble.animation()
        bubble.addTarget(self, action: #selector(bubblePressed), for: .touchUpInside)
        self.view.addSubview(bubble)
    }
    
    @IBAction func bubblePressed(_ sender: UIButton) {
        // remove pressed bubble from view
        sender.removeFromSuperview()
    }
    
}

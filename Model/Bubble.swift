//
//  Bubble.swift
//  BubblePop
//
//  Created by Christopher Vuong on 6/4/2022.
//

import Foundation
import UIKit

class Bubble: UIButton {
    
    let xPosition = Int.random(in: 20...Int(UIScreen.main.bounds.size.width * 0.7))
    let yPosition = Int.random(in: 130...Int(UIScreen.main.bounds.size.height * 0.8))
    let randomInt = Int.random(in: 0...100)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        switch randomInt {
            case 0..<40:
                self.backgroundColor = .red
            case 40..<70:
                self.backgroundColor = .magenta
            case 70..<85:
                self.backgroundColor = .green
            case 85..<95:
                self.backgroundColor = .blue
            default:
                self.backgroundColor = .black
        }
        self.frame = CGRect(x: xPosition, y: yPosition, width: 80, height: 80)
        self.layer.cornerRadius = 0.5 * self.bounds.size.width
    }
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    func animation() {
        let springAnimation = CASpringAnimation(keyPath: "transform.scale")
        springAnimation.duration = 0.6
        springAnimation.fromValue = 1
        springAnimation.toValue = 0.8
        springAnimation.repeatCount = 1
        springAnimation.initialVelocity = 0.5
        springAnimation.damping = 1
        
        layer.add(springAnimation, forKey: nil)
    }
    
    func flash() {
        
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 0.2
        flash.fromValue = 1
        flash.toValue = 0.1
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        flash.autoreverses = true
        flash.repeatCount = 3
        
        layer.add(flash, forKey: nil)
    }
    
}

//
//  SettingViewController.swift
//  BubblePop
//
//  Created by Christopher Vuong on 6/4/2022.
//

import Foundation
import UIKit

class SettingViewController: UIViewController, UITextFieldDelegate {
        
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var timeSlider: UISlider!
    @IBOutlet weak var numOfBubblesSlider: UISlider!
    @IBOutlet weak var timeSliderValue: UILabel!
    @IBOutlet weak var numOfBubblesValue: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.nameTextField.delegate = self
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToGame" {
            let VC = segue.destination as! GameViewController
            VC.name = nameTextField.text!
            VC.remainingTime = Int(timeSlider.value)
            VC.numOfBubbles = Int(numOfBubblesSlider.value)
        }
    }
    
    @IBAction func timeSliderValueChanged(_ sender: Any) {
        timeSliderValue.text = String(Int(timeSlider.value))
    }
    
    
    @IBAction func numOfBubblesSliderValueChanged(_ sender: Any) {
        numOfBubblesValue.text = String(Int(numOfBubblesSlider.value))
    }
    
    // Removes the keyboard when the user taps on the return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTextField {
            textField.resignFirstResponder()
        }
        return false
    }
    
}

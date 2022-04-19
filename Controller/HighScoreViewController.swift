//
//  HighScoreViewController.swift
//  BubblePop
//
//  Created by Christopher Vuong on 6/4/2022.
//

import Foundation
import UIKit

struct GameScore: Codable {
    var name: String
    var score: Int
}

let KEY_HIGH_SCORE = "highScores"

class HighScoreViewController: UIViewController {

    var highScores: [GameScore] = []
    var currentPlayerName = "Unknown"
    var currentGameScore = 100
    var newScore = false
    
    
    @IBOutlet weak var highScoreTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if newScore == true {
            writeHighScores()
        }
        
        self.highScores = readHighScores()
        
        highScores.sort {
            $0.score > $1.score
        }
    }
    
    func writeHighScores() {
        let defaults = UserDefaults.standard
        
        
        let updatedHighScoreFromGame = [
            GameScore(name: currentPlayerName, score: currentGameScore)
        ]
        
        defaults.set(try? PropertyListEncoder().encode(updatedHighScoreFromGame), forKey: KEY_HIGH_SCORE)
    }
    
    func readHighScores() -> [GameScore] {
        let defaults = UserDefaults.standard
        
        if let savedArrayData = defaults.value(forKey:KEY_HIGH_SCORE) as? Data {
            if let array = try? PropertyListDecoder().decode(Array<GameScore>.self, from: savedArrayData) {
                return array
            } else {
                return []
            }
        } else {
            return []
        }
    }

    @IBAction func returnToMainPage(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}

extension HighScoreViewController: UITableViewDelegate {
    /*
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        <#code#>
    }
     */
    
}

extension HighScoreViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return highScores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "highScoreCell", for: indexPath)
        let score = highScores[indexPath.row]
        
        cell.textLabel?.text = score.name
        cell.detailTextLabel?.text = String(score.score)
        
        return cell
    }
    
    
}

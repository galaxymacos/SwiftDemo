//
//  ViewController.swift
//  Project2
//
//  Created by Xun Ruan on 2021/8/4.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries: [String] = []
    var correctAnswer = -1
    var score = 0
    var numofQuestionAsked = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        countries+=["estonia", "france", "germany", "ireland", "italy", "manaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(showScoreTapped))
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
    
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion()
    }
    
    @objc func showScoreTapped(){
        // Create an alert (Just the alert, no button to click)
        let ac = UIAlertController(title: "Score", message: "\(score)", preferredStyle: .alert)
        // handler: after we hit the button
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
        
        // completion: after we present the alert
        present(ac, animated: true, completion: nil)
    }

    // Swift want to know which alert is tapped
    func askQuestion(action: UIAlertAction! = nil){
        if(numofQuestionAsked >= 3){
            let ac = UIAlertController(title: "Final Score", message: "\(score)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
            present(ac, animated: true, completion: nil)
        }
        numofQuestionAsked += 1
        countries.shuffle()
        // .normal is an enum in Objective-C but a struct in Swift
        // .normal means the the button state is not highlighted or in any other special condition
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        correctAnswer = Int.random(in: 0...2)
        let str = String(repeating: " ", count: 15-countries[correctAnswer].count)
        title = countries[correctAnswer].uppercased() + str + "Player Score: \(score)"
    }
    
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        print("button tapped")
        
        
        if sender.tag == correctAnswer{
            title = "Correct"
            score += 1
            presentScoreAlert()
        }
        else{
            title = "Wrong"
            let ac = UIAlertController(title: "Wrong", message: "That's the flag of \(countries[sender.tag])", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: presentScoreAlert))
            score -= 1
            present(ac, animated: true, completion: nil)
        }
    }
    
    func presentScoreAlert(_ action: UIAlertAction! = nil){
        // Create an alert (Just the alert, no button to click)
        let ac = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
        // handler: after we hit the button
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        
        // completion: after we present the alert
        present(ac, animated: true, completion: nil)
    }
}


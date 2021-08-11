//
//  ViewController.swift
//  Challenge3_Hangman
//
//  Created by Xun Ruan on 2021/8/11.
//

import UIKit

class ViewController: UIViewController {

    var selectedWord: String = ""
    var words = ["fantastic"]
    
    var tryBtn: UIButton!
    var inputField: UITextField!
    var hintLabel: UILabel!
    var wordLabel: UILabel!
    var wordShownText:[Int: Bool] = [:]{
        didSet{
            wordLabel.text = ""
            for index in 0..<selectedWord.count{
                if(wordShownText[index] == true){   // has guessed
                    let array = Array(selectedWord)
                    let cha = array[index]
                    wordLabel.text! += String(cha) + " "
                }
                else{
                    wordLabel.text! += "_ "
                }
            }
        }
    }
    

    var numTry: Int = 0{
        didSet{
            if numTry >= 7{
                let ac = UIAlertController(title: "You lose", message: "You have tried seven times", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Try again", style: .default, handler: nil))
                present(ac, animated: true)
            }
            hintLabel.text = "Number of try: \(numTry)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        selectedWord = words.randomElement() ?? ""
        
        tryBtn = UIButton(type: .system)
        tryBtn.translatesAutoresizingMaskIntoConstraints = false
        
        tryBtn.setTitle("Try", for: .normal)
        tryBtn.addTarget(self, action: #selector(tryRemoveLetter), for: .touchUpInside)
        view.addSubview(tryBtn)
        
        hintLabel = UILabel()
        hintLabel.translatesAutoresizingMaskIntoConstraints = false
        hintLabel.font = UIFont.systemFont(ofSize: 24)
        hintLabel.text = "Number of try: \(numTry)"
        hintLabel.numberOfLines = 0
        hintLabel.textAlignment = .center
        view.addSubview(hintLabel)
        
        wordLabel = UILabel()
        wordLabel.translatesAutoresizingMaskIntoConstraints = false
        wordLabel.font = UIFont.systemFont(ofSize: 20)
        for (index, _) in selectedWord.enumerated(){
            wordShownText[index] = false
        }
        view.addSubview(wordLabel)
        
        inputField = UITextField()
        inputField.translatesAutoresizingMaskIntoConstraints = false
        inputField.placeholder = "placeholder"
        inputField.autocapitalizationType = .none
        inputField.font = UIFont.systemFont(ofSize: 24)
        inputField.textAlignment = .center
        view.addSubview(inputField)
        
        
        
        NSLayoutConstraint.activate([
            hintLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            hintLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            wordLabel.bottomAnchor.constraint(equalTo: inputField.topAnchor),
            wordLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            inputField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            inputField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            tryBtn.topAnchor.constraint(equalTo: inputField.bottomAnchor),
            tryBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
        ])
    }

    // return true if player has won the game
    @objc func tryRemoveLetter(){
        guard let text = inputField.text else {return}
        var guessRight = false
        var shouldGameOver = true
        for index in 0..<selectedWord.count{
            if String(selectedWord[selectedWord.index(selectedWord.startIndex, offsetBy: index)]) == text && wordShownText[index] == false{
                guessRight = true
                wordShownText[index] = true
                print(index)
            }
            if wordShownText[index] == false{
                shouldGameOver = false
            }
        }
        inputField.text = ""
        if !guessRight{
            numTry+=1
        }
        if shouldGameOver{
            gameOver()
            return
        }
    }
    
    //
    func gameOver(){
        let ac = UIAlertController(title: "You won", message: "With only \(numTry) tries", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Finish", style: .default, handler: nil))
        present(ac, animated: true)
        
        inputField.isUserInteractionEnabled = false
    }
}


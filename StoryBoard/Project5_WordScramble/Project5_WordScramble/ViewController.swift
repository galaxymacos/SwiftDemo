//
//  ViewController.swift
//  Project5_WordScramble
//
//  Created by Xun Ruan on 2021/8/6.
//

import UIKit

class ViewController: UITableViewController {

    var allWords = [String]()
    var usedWords = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        if let startWordsUrl = Bundle.main.url(forResource: "start", withExtension: "txt"){
            if let startWords = try? String(contentsOf: startWordsUrl){
                allWords = startWords.components(separatedBy: "\n")
            }
        }
        if allWords.isEmpty{
            allWords = ["silkworm"]
        }
        startGame()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .redo, target: self, action: #selector(restartGame))
    }
    
    @objc func restartGame(){
        startGame()
    }
    
    @objc func promptForAnswer(){
        let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        ac.addTextField(configurationHandler: nil)  // You can configure how does it look
        
        
        // The closure accepts a variable of the type UIAlertAction
        let submitAction = UIAlertAction(title: "Submit", style: .default){ [weak self, weak ac] action in  // use weak because we don't want it to hold onto the AlertController or the ViewController if we already decide to delete the view controller or the alert controller
            guard let answer = ac?.textFields?[0].text else { return }  // text field is accessed by its index in the array
            self?.submit(answer)    // By using self, we are clearly acknowledging the possibility of a strong reference cycle
        }
        
        //
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    func submit(_ str: String){
        let lowercasedAnswer = str.lowercased()
        if isOriginal(lowercasedAnswer){
            if isPossible(lowercasedAnswer){
                if isReal(lowercasedAnswer){
                    usedWords.insert(lowercasedAnswer, at: 0)
                    let indexPath = IndexPath(row: 0, section: 0)
                    
                    // .automatic means do whatever that's standard system animation for this change
                    // In inserting a row, it means sliding the new row in from the top
                    tableView.insertRows(at: [indexPath], with: .automatic)
//                    tableView.reloadData() // Not efficient and the animation can't figure out that we just add a row
                    return
                }
                else{
                    showErrorMessage("Word not recognized", "You cannot just made up a word")
                }
            }
            else{
                showErrorMessage("Word not possible to get", "You cannot make a word using the letter \(title!)")
            }
            
        }
        else{
            showErrorMessage("Word already exists", "You need to figure out new word")
        }
        
    }
    
    func isOriginal(_ answer: String)->Bool{
        return !usedWords.contains(answer)
    }
    
    func isPossible(_ answer: String)->Bool{
        guard var tempWord = title?.lowercased() else {return false}
        
        for letter in answer{
            let index = tempWord.firstIndex(of: letter)
            if let index = index{
                tempWord.remove(at: index)
            }
            else{
                return false
            }
        }
        return true
    }
    
    func isReal(_ answer: String)->Bool{
        if answer.count <= 3{
            return false
        }
        if let title = title{
            if title.starts(with: answer){
                return false
            }
        }
        
        let textChecker = UITextChecker()
        // utf-8 vs. utf-16: swift's navive is to store character as itself, however, uikit stores the character and the accent separately, meaning that é and emoji will be counted as 2-letter long in UIKit but in SwiftUI it will be only 1-letter long
        let range = NSRange(location: 0, length: answer.utf16.count)
        let misspelledRange = textChecker.rangeOfMisspelledWord(in: answer, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound   // Usually the location is the index of where the error startes, but NSFotFound is a special error that tells user no error were found
        
    }
    
    func showErrorMessage(_ errorTitle: String, _ errorMessage: String){
        
        let ac = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
        present(ac, animated: true)
    }

    func startGame(){
        title = allWords.randomElement()
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }

}


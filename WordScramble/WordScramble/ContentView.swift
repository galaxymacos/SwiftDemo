//
//  ContentView.swift
//  WordScramble
//
//  Created by Xun Ruan on 2021-07-06.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = "Root Word"
    @State private var newWord = ""
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showAlert = false
    var body: some View {
        
        NavigationView{
            VStack{
                TextField("Enter your word: ", text: $newWord, onCommit: addNewWord)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                
                
                List(usedWords, id: \.self){
                    Image(systemName: "\($0.count).circle")
                    Text($0)
                }
            }.navigationBarTitle(Text("\(rootWord)"))
            .onAppear(perform: startGame)
            .alert(isPresented: $showAlert, content: {
                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("Ok")))
            })
        }
    }
    
    func addNewWord(){
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count>0 else {
            return
        }
        guard isOriginal(word: answer) else {
            showError(alertTitle: "Not original", alertMessage: "Word already existed")
            return
        }
        guard isReal(word: answer) else {
            showError(alertTitle: "Not real", alertMessage: "It isn't a word")
            return
        }
        guard isPossible(word: answer) else {
            showError(alertTitle: "Not possible", alertMessage: "The word doesn't compose of the letter in the root word")
            return
        }
        
        usedWords.insert(newWord, at: 0)
        newWord = ""
    }
    
    func startGame(){
        if let startContentUrl = Bundle.main.url(forResource: "start", withExtension: "txt"){
            if let str = try? String(contentsOf: startContentUrl){
                let words = str.components(separatedBy: "\n")
                rootWord = words.randomElement() ?? "Silkworm"
                return
            }
            
        }
        fatalError("Could not load start.txt from the file")
    }
    
    func isOriginal(word: String)->Bool{
        return !usedWords.contains(word)
    }
    
    func isReal(word: String)->Bool{
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misSpelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        if(misSpelledRange.location == NSNotFound){
            return true
        }
        return false
    }
    
    func isPossible(word: String)->Bool{
        var rootCopy = rootWord
        for letter in word{
            if let pos = rootCopy.firstIndex(of: letter){
                rootCopy.remove(at: pos)
            }
            else{
                return false
            }
        }
        return true
    }
    
    func showError(alertTitle: String, alertMessage: String){
        self.alertTitle = alertTitle
        self.alertMessage = alertMessage
        self.showAlert = true
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

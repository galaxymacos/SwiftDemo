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
    
    private var score:Int {
        var myScore = 0
        for word in usedWords {
            myScore+=word.count
        }
        return myScore
    }
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showAlert = false
    var body: some View {
        
        NavigationView{
            GeometryReader{fullView in
                VStack{
                    TextField("Enter your word: ", text: $newWord, onCommit: addNewWord)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    
                    
                    List(usedWords, id: \.self){ usedWord in
                        if usedWords.count <= 7{
                            HStack{
                                Image(systemName: "\(usedWord.count).circle")
                                Text(usedWord).padding([.leading])
                                
                            }
                        }
                        else{
                            if usedWords.firstIndex(of: usedWord)! <= 7{
                                HStack{
                                    Image(systemName: "\(usedWord.count).circle")
                                    Text(usedWord).padding([.leading])
                                }
                            }
                            else{
                                GeometryReader{geo in
                                    HStack{
                                        Image(systemName: "\(usedWord.count).circle")
                                        Text(usedWord).padding([.leading])
                                    }
                                    .offset(x: geo.frame(in: .global).midY / fullView.size.height * 2000 - 1877 < 0 ? 0 : geo.frame(in: .global).midY / fullView.size.height * 2000 - 1877, y: 0)
                                }
                                
                            }
                            
                        }
                    }
                    Text("Score: \(score)")
                    Spacer()
                    
                }.navigationBarTitle(Text("\(rootWord)"))
                .onAppear(perform: startGame)
                .alert(isPresented: $showAlert, content: {
                    Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("Ok")))
                })
                .navigationBarItems(leading: Button(action:startGame){
                    Text("Start game")
                })
                
            }
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
        if(word.count < 3){
            return false
        }
        if(rootWord.hasPrefix(word)){
            return false
        }
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

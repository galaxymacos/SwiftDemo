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
        }
    }
    
    func addNewWord(){
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count>0 else {
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

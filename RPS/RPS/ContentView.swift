//
//  ContentView.swift
//  RPS
//
//  Created by Xun Ruan on 2021-07-05.
//

import SwiftUI

struct ContentView: View {
    let kinds = ["rock", "paper", "scissor"]
    @State var showAlert = false
    @State var alertMessage:String = ""
    @State var alertTitle:String = ""
    @State var score: Int = 0
    @State var gameEnds: Bool = false
    
    enum KindRelationship {
        case win
        case lose
    }

    func findKindRelation(kind: String, relationship: KindRelationship)->String{
        if(relationship == .win){
            return kinds[(kinds.firstIndex(of: kind)!+1)%kinds.count]
        }
        else{
            return kinds[(kinds.firstIndex(of: kind)!-1)%kinds.count]
        }
    }

    @State var randomChoice: Int = Int.random(in: 0..<3)
    var comKind: String {
        get{
            return kinds[randomChoice]
        }
    }

    @State var randomWinCondition: Bool = Bool.random()
    var comRelationship: KindRelationship{
        get{
            return randomWinCondition ? .win:.lose
        }
    }
    
    var body: some View {
        VStack(spacing: 20){
            Text("Com picks \(kinds[randomChoice])")
            Text("Your purpose is to \(randomWinCondition ? "win":"lose")")
            ForEach(0..<3){ number in
                Button(action: {printOutMessage(number: number)}){
                    Text(kinds[number])
                }.alert(isPresented: $showAlert, content: {
                    Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("continue"), action: gameRestart))
                })
            }
        }
    }
    
    func printOutMessage(number: Int){
        
        
        if(findKindRelation(kind: comKind, relationship: comRelationship) == kinds[number]){
            alertTitle = "You win"
            score+=1
        }
        else{
            alertTitle = "You lose"
            score-=1
        }
        alertMessage = "You score is now: \(score)"
        showAlert = true
    }

    func gameRestart(){
        randomChoice = Int.random(in: 0..<3)
        randomWinCondition = Bool.random()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

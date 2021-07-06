//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Xun Ruan on 2021/7/3.
//

import SwiftUI

struct ContentView: View {
    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
    @State var correctAnswerIndex = Int.random(in: 0...2)
    @State var scoreTitle = ""
    @State var isShowingScore = false
    @State var score = 0
    var body: some View {
      
        ZStack{
            // .edgeIgnoringSafeArea(.all) or ignoringSafeArea(edge: .all)
//            Color.blue.edgesIgnoringSafeArea(.all)
            LinearGradient(colors: [.blue, .black], startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            VStack(spacing: 30){
                VStack{
                    Text("Tag the flag of ").foregroundColor(.white)
                    Text(countries[correctAnswerIndex]).foregroundColor(.white).font(.largeTitle).fontWeight(.bold)
                
                }
                
                ForEach(0..<3){ number in
                    Button(action: {FlagTapped(number: number)}){
                        Image(countries[number])
                            .renderingMode(.original)
                            // Cut the image to be a shape
                            .clipShape(Capsule())
                            // go D
                            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                            .shadow(color: .black, radius: 2, x: 0, y: 0)
                    }
                }
                
                Text("Score: \(score)").foregroundColor(.white)
            }
//            
            
        }.alert(isPresented: $isShowingScore){
            Alert(title: Text(scoreTitle), message: Text("Score: \(score)"), dismissButton: .default(Text("Continue?")){
                askQuestion()
            })
        }
        
    }
    
    func FlagTapped(number: Int){
        if number == correctAnswerIndex{
            scoreTitle = "True"
            score += 10
        }
        else{
            scoreTitle = "Wrong. That's the flag of \(countries[number])"
        }
        isShowingScore = true
    }
    
    func askQuestion(){
        countries.shuffle()
        correctAnswerIndex = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

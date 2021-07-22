//
//  ContentView.swift
//  AnkiCopy
//
//  Created by Xun Ruan on 2021/7/21.
//

import SwiftUI

extension View{
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = total - position
        return self.offset(x: 0, y: CGFloat(offset * 10))
    }
}

struct ContentView: View {
    @State var cards = [Card](repeating: Card.example, count: 10)
    @State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var isActive = true
    @State var timeRemaining = 100
    
    
    var body: some View {
        ZStack{
            // Background Image
            Image("background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            VStack{
                // Timer
                Text("Time: \(timeRemaining)")
                    .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 5)
                    .background(
                        Capsule()
                            .fill(Color.black)
                            .opacity(0.7)
                    )
                // Card
                ZStack{
                    ForEach(0..<cards.count, id: \.self){ index in
                        CardView(card: Card.example, removal: {
                            withAnimation{
                                removeCard(index: index)
                            }
                        })
                        .stacked(at: index, in: cards.count)
                    }
                    
                }.allowsHitTesting(timeRemaining>0)
                
                if cards.isEmpty{
                    Button("Start again", action: resetCards)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.black)
                        .clipShape(Capsule())
                }
            }
            
        }
        .onReceive(timer, perform: { _ in
            // Stop timer from running in the background
            guard isActive else {return}
            if(timeRemaining>0){
                timeRemaining -= 1
            }
        })
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification), perform: { _ in
            isActive = false
        })
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.didEnterBackgroundNotification), perform: { _ in
            if !cards.isEmpty{                
                isActive = true
            }
        })
    }
    
    func removeCard(index: Int) {
        cards.remove(at: index)
        if cards.isEmpty{
            isActive = false
        }
    }
    
    func resetCards(){
        cards = [Card](repeating: Card.example, count: 10)
        timeRemaining = 100
        isActive = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

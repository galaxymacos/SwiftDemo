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
    @State var cards = [Card]()
    @State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var isActive = true
    @State var timeRemaining = 100
    @State var showingEditScreen = false
    
    
    var body: some View {
        ZStack{
            // Background Image
            Image(decorative:"background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            VStack{
                ZStack{
                    
                    HStack{
                        Spacer()
                        Button(action: {showingEditScreen = true}){
                            Image(systemName: "plus.circle")
                                
                                .padding()
                                .background(Color.black.opacity(0.7))
                                .font(.largeTitle)
                                .clipShape(Circle())
                        }
                        
                    }
                    
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
                }
                // Card
                ZStack{
                    ForEach(0..<cards.count, id: \.self){ index in
                        CardView(card: cards[index], removal: {
                            withAnimation{
                                removeCard(index: index)
                            }
                        })
                        .stacked(at: index, in: cards.count)
                        // Allow only the last element of the ForEach loop to be dragged
                        .allowsHitTesting(index == cards.count - 1)
                        // Don't allow accessibility sound when user click the card behind
                        .accessibility(hidden: index < cards.count - 1)
                    }
                    VStack{
                        Spacer()
                        HStack{
                            Button(action: {
                                withAnimation{
                                    removeCard(index: cards.count - 1)
                                }
                            }){
                                Image(systemName: "xmark.circle")
                                    .padding()
                                    .background(Color.black.opacity(0.7))
                                    .clipShape(Circle())
                            }
                            .padding([.trailing])
                            .accessibility(label: Text("You get it correct"))
                            
                            Button(action: {
                                withAnimation{
                                    removeCard(index: cards.count - 1)
                                }
                            }){
                                Image(systemName: "checkmark.circle")
                                    .padding()
                                    .background(Color.black.opacity(0.7))
                                    .clipShape(Circle())
                            }
                            .padding([.leading])
                            .accessibility(label: Text("You get it wrong"))
                        }
                    }
                    
                }
                .allowsHitTesting(timeRemaining>0)
                .foregroundColor(.white)
                .font(.largeTitle)
                .padding()
                
                
                
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
        .onAppear(perform: resetCards)
        .sheet(isPresented: $showingEditScreen, onDismiss: resetCards){
            EditCards()
        }
    }
    
    func removeCard(index: Int) {
        cards.remove(at: index)
        if cards.isEmpty{
            isActive = false
        }
    }
    
    func resetCards(){
        loadData()
        timeRemaining = 100
        isActive = true
    }
    
    func loadData(){
        if let data = UserDefaults.standard.data(forKey: "data"){
            if let decoded = try? JSONDecoder().decode([Card].self, from: data){
                cards = decoded
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

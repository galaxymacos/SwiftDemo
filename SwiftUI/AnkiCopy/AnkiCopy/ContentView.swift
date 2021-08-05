//
//  ContentView.swift
//  AnkiCopy
//
//  Created by Xun Ruan on 2021/7/21.
//

import SwiftUI
import CoreHaptics

extension View{
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = total - position
        return self.offset(x: 0, y: CGFloat(offset * 10))
            
    }
}

struct ContentView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @State var cards = [Card]()
    @State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var isActive = true
    @State var timeRemaining = 100
    @State var showingEditScreen = false
    @State var showingSettingScreen = false
    @State var hapticEngine: CHHapticEngine?
    @State var showReviewIncorrectCard = false
    
    
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
                        
                        Button(action: {showingSettingScreen = true}){
                            Image(systemName: "gear")
                                .padding()
                                .background(Color.black.opacity(0.7))
                                .font(.largeTitle)
                                .clipShape(Circle())
                        }
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
                        if differentiateWithoutColor{
                            HStack{
                                // Can't remember button
                                Button(action: {
                                    withAnimation{
                                        
                                        if showReviewIncorrectCard {
                                            let cardToRemove = cards[cards.count - 1]
                                            cards.remove(at: cards.count-1)
                                            cards.insert(cardToRemove, at: 0)
                                        }
                                        else{
                                            removeCard(index: cards.count - 1)
                                        }
                                        
                                        activateFailureHaptic()
                                    }
                                }){
                                    Image(systemName: "xmark.circle")
                                        .padding()
                                        .background(Color.black.opacity(0.7))
                                        .clipShape(Circle())
                                }
                                .padding([.trailing])
                                .accessibility(label: Text("You get it correct"))
                                
                                // Can remember button
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
            .sheet(isPresented: $showingSettingScreen){
                SettingScreen(recoverCard: $showReviewIncorrectCard)
            }
            
        }
        .onReceive(timer, perform: { _ in
            // Stop timer from running in the background
            guard isActive else {return}
            if(timeRemaining>0){
                prepareHaptic()
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
    
    func prepareHaptic(){
            guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else {return}
        do {
            // Try Initializing haptic engine
            hapticEngine = try CHHapticEngine()
            // Try start haptic engine
            try hapticEngine?.start()
            
        }
        catch{
            print(error.localizedDescription)
        }
    }
    
    func activateFailureHaptic(){
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else {return}
        var events = [CHHapticEvent]()
        
        for i in stride(from: 1, to: 0, by: 0.1){
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(i))
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [sharpness, intensity], relativeTime: 0)
            events.append(event)
        }
        
        do{
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try hapticEngine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        }
        catch{
            print("Failed to play pattern: \(error.localizedDescription)")
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

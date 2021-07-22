//
//  ContentView.swift
//  Haptic
//
//  Created by Xun Ruan on 2021/7/21.
//

import SwiftUI

/* Simple haptic
 struct ContentView: View {
 var body: some View {
 Text("Hello, world!")
 .padding()
 .onTapGesture(perform: simpleSuccess)
 }
 
 func simpleSuccess(){
 let generator = UINotificationFeedbackGenerator()
 generator.notificationOccurred(.success)
 }
 }
 */

/* Complex haptic
 */
import CoreHaptics

struct ContentView: View {
    
    @State private var engine: CHHapticEngine?
    
    var body: some View{
        Text("Tap to show haptic")
            .onAppear(perform: prepareHaptic)
            .onTapGesture(perform: complexSuccess)
    }
    
    func prepareHaptic(){
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else {return}
        
        do{
            self.engine = try CHHapticEngine()
            try? engine?.start()
        }
        catch{
            print("There was an error when creating the engine")
        }
    }
    
    func complexSuccess(){
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else {return}
        
        var events = [CHHapticEvent]()
        /* making a 1 second strong haptic
         var sharpess = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
         var intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
         let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpess], relativeTime: 0)
         events.append(event)
         */
        
        /* making haptic rise and sink
         */
        for i in stride(from: 0, to: 1, by: 0.1){
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(i))
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
            events.append(event)
        }
        for i in stride(from: 1, to: 0, by: 0.1){
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(i))
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
            events.append(event)
        }
        
        do{
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        }catch{
            print("Failed to play pattern: \(error.localizedDescription)")
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


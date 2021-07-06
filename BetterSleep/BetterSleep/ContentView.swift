//
//  ContentView.swift
//  BetterSleep
//
//  Created by Xun Ruan on 2021-07-06.
//

import SwiftUI

struct ContentView: View {
    @State var sleepHour:Double = 7
    @State var whenToWakeUp = Date()
    @State var cupCoffee = 1
    var body: some View {
        NavigationView{
            VStack(spacing: 50){
                Text("When do you want to wake up?").font(.headline)
                DatePicker("Time", selection: $whenToWakeUp, displayedComponents: .hourAndMinute).labelsHidden()
                
                Text("How many hours do you want to sleep?")
                Stepper(value: $sleepHour, in: 4...12, step: 0.25) {
                    Text("\(sleepHour, specifier: "%g") hours")
                }
                
                Text("How many cups of coffee you drink per day?")
                Stepper(value: $cupCoffee, in: 1...20){
                    if(cupCoffee == 1){
                        Text("1 cup")
                    }
                    else{
                        Text("\(cupCoffee) cups")
                    }
                }
                
            }
            .navigationBarTitle(Text("Sleep well"))
            .navigationBarItems(trailing: Button(action: CalculateSleepHour){
                Text("Calculate")
            })
            
        }
        
    }
    
}

func CalculateSleepHour(){
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

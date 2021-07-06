//
//  ContentView.swift
//  BetterSleep
//
//  Created by Xun Ruan on 2021-07-06.
//

import SwiftUI

struct ContentView: View {
    @State var sleepHour:Double = 7
    @State var wakeUp = Date()
    @State var cupCoffee = 1
    @State var alertTitle = ""
    @State var alertMessage = ""
    @State var showAlert = false
    let model = SleepCalculator()
    var body: some View {
        NavigationView{
            VStack(spacing: 50){
                Text("When do you want to wake up?").font(.headline)
                DatePicker("Time", selection: $wakeUp, displayedComponents: .hourAndMinute).labelsHidden()
                
                Text("How many hours do you want to sleep?")
                Stepper(value: $sleepHour, in: 4...12, step: 0.25) {
                    Text("\(sleepHour, specifier: "%g") hours")
                }
                
                Text("How many cups of coffee you drink per day?")
                Stepper(value: $cupCoffee, in: 0...20){
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
            .alert(isPresented: $showAlert){
                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("Ok")))
            }
        
        }
        
    }
    func CalculateSleepHour(){
        // from Date to DateComponent
        let wakeUpDC = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        // Retrieve hour and minute (in second) from DateComponent
        let wakeUpHour = (wakeUpDC.hour ?? 0) * 60 * 60
        let wakeUpMinute = (wakeUpDC.minute ?? 0) * 60
        
        let prediction = try! model.prediction(wake: Double(wakeUpHour + wakeUpMinute), estimatedSleep: sleepHour, coffee: Double(cupCoffee))
        
        let timeToSleep = wakeUp - prediction.actualSleep
        alertTitle = "Calculated!"
        
        // from Date to String
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        
        alertMessage = "Your need to go to sleep at \(formatter.string(from: timeToSleep))"
        
        
        showAlert = true
        
        
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

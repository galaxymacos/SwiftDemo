//
//  ContentView.swift
//  BetterSleep
//
//  Created by Xun Ruan on 2021-07-06.
//

import SwiftUI

struct ContentView: View {
    @State var sleepHour:Double = 7
    @State var wakeUp = defaultWakeTime
    @State var cupCoffee = 1
    @State var alertTitle = ""
    @State var alertMessage = ""
    @State var showAlert = false
    // can't instantiate one variable in swift based on another variable, because there is no sequence in swift
    static var defaultWakeTime: Date{
        var dateComponent = DateComponents()
        dateComponent.hour = 7
        dateComponent.minute = 0
        return Calendar.current.date(from: dateComponent) ?? Date()
    }
    var desiredSleepTime: String {
        CalculateSleepHour()
    }
    
    let model = SleepCalculator()
    var body: some View {
        NavigationView{
            Form(){
                VStack(alignment: .leading, spacing: 0){
                    Text("When do you want to wake up?").font(.headline)
                    DatePicker("Time", selection: $wakeUp, displayedComponents: .hourAndMinute).datePickerStyle(WheelDatePickerStyle()).labelsHidden()
                }
                
                Section(header:Text("How many hours do you want to sleep?")){
                    Stepper(value: $sleepHour, in: 4...12, step: 0.25) {
                        Text("\(sleepHour, specifier: "%g") hours")
                    }
                }
                
                Section(header:Text("How many cups of coffee you drink per day?")){
                    Stepper(value: $cupCoffee, in: 0...20){
                        if(cupCoffee == 1){
                            Text("1 cup")
                        }
                        else{
                            Text("\(cupCoffee) cups")
                        }
                    }
                    Picker("Amount", selection: $cupCoffee){
                        ForEach(0..<21){ number in
                            if(number == 1 || number == 0){
                                Text("\(number) cup")
                            }
                            else{
                                Text("\(number) cups")
                            }
                            
                        }
                    }
                }
                
                Section(header: Text("Desired sleep time")){
                    Text("\(desiredSleepTime)")
                }
                
            }
            .navigationBarTitle(Text("Sleep well"))
        }
        
    }
    func CalculateSleepHour()->String{
        // from Date to DateComponent
        let wakeUpDC = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        // Retrieve hour and minute (in second) from DateComponent
        let wakeUpHour = (wakeUpDC.hour ?? 0) * 60 * 60
        let wakeUpMinute = (wakeUpDC.minute ?? 0) * 60
        
        let prediction = try! model.prediction(wake: Double(wakeUpHour + wakeUpMinute), estimatedSleep: sleepHour, coffee: Double(cupCoffee))
        
        let timeToSleep = wakeUp - prediction.actualSleep
        
        // from Date to String
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        
        return formatter.string(from:timeToSleep)

        
        
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

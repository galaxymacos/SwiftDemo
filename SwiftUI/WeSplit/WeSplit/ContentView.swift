//
//  ContentView.swift
//  WeSplit
//
//  Created by Xun Ruan on 2021/7/2.
//

import SwiftUI


struct ContentView: View {
    @State var checkAmountS = ""
    @State var numOfPeopleS = "2"
    @State var tipSelectionIndex = 0
    
    var totalAmountOfCheck:Double{
        let checkAmount:Double = (Double)(checkAmountS) ?? 0
        let tip = (Double)(tipAmounts[tipSelectionIndex])/100 * checkAmount
        return checkAmount + tip
    }
    
    var totalPerPerson:Double {
        
        let checkAmount:Double = (Double)(checkAmountS) ?? 0
        let numOfPeople: Int = (Int)(numOfPeopleS) ?? 1
        if numOfPeople<1 {
            return 0
        }
        let tip = (Double)(tipAmounts[tipSelectionIndex])/100 * checkAmount
        return (checkAmount + tip)/(Double)(numOfPeople)
    }
    
    
    let tipAmounts = [10,15,20,25,30]
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                
                    TextField("Amount", text:$checkAmountS)
                        .keyboardType(.decimalPad)
                }
                
                Section(header: Text("How much tip do you want to leave")){
                    Picker("Tip percentage", selection: $tipSelectionIndex){
                        ForEach(0..<tipAmounts.count){
                            Text("\(tipAmounts[$0])%")
                        }
                    }
                    // .pickerStyle(.segment)
                    .pickerStyle(SegmentedPickerStyle())    // Look much better
                // textCase(nil) allows us to keep the original letter case, else the header will be uppercase by default
                }.textCase(nil)
                
                Section(header: Text("Number of people")){
//                    Picker("People", selection: $numOfPeopleIndex){
//                        ForEach(2..<100){
//                            Text("\($0) people")
//                        }
//                    }
                    TextField("2", text:$numOfPeopleS)
                }
                
                Section(header:Text("Total amount of check: ")){
                    Text("\(totalAmountOfCheck)")
                }
                
                Section(header:Text("Amount per person")){
                    // specifier: Round the number to 2 decimal points
                    // %.g will remove insignificant trailing zero, %.f won't
                    Text("Total per person: $\(totalPerPerson, specifier: "%.2g")")
                }.textCase(nil)
                
            }
            .navigationBarTitle("We Split")
        }
        
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

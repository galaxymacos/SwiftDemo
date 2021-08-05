//
//  ContentView.swift
//  VolumeConverter
//
//  Created by Xun Ruan on 2021/7/3.
//

import SwiftUI

struct ContentView: View {
    @State var sourceVolumeSelectionIndex = 0
    @State var endVolumeSelectionIndex = 0
    @State var numOfVolumeS: String = ""
    var endVolumeAmount:Double{
        var unitifiedVolume = Measurement(value: numOfVolume, unit: UnitVolume.milliliters)
        
        switch sourceVolumeSelectionIndex{
            case 0:
                unitifiedVolume = Measurement(value: numOfVolume, unit: UnitVolume.milliliters)
            case 1:
                unitifiedVolume = Measurement(value: numOfVolume, unit: UnitVolume.liters)
            case 2:
                unitifiedVolume = Measurement(value: numOfVolume, unit: UnitVolume.cups)
            case 3:
                unitifiedVolume = Measurement(value: numOfVolume, unit: UnitVolume.pints)
            case 4:
                unitifiedVolume = Measurement(value: numOfVolume, unit: UnitVolume.gallons)
            default:
                return 0
        }
        
        switch endVolumeSelectionIndex{
            case 0:
                return unitifiedVolume.converted(to: .milliliters).value
            case 1:
                return unitifiedVolume.converted(to: .liters).value
            case 2:
                return unitifiedVolume.converted(to: .cups).value
            case 3:
                return unitifiedVolume.converted(to: .pints).value
            case 4:
                return unitifiedVolume.converted(to: .gallons).value
            default:
                return 0
        }
    }
    var numOfVolume: Double{
        return (Double)(numOfVolumeS) ?? 0.0
    }
    let volumes = ["milliliters", "liters", "cups", "pints", "gallons"]
    var body: some View {
        NavigationView{
            Form{
                Section(header:Text("Amount")){
                    TextField("0", text: $numOfVolumeS).keyboardType(.decimalPad)
                }
                
                Section(header:Text("Units")){
                    Picker("From", selection: $sourceVolumeSelectionIndex){
                        ForEach(0..<volumes.count){
                            Text(volumes[$0])
                        }
                    }.pickerStyle(.automatic)
                    
                    Picker("To", selection: $endVolumeSelectionIndex){
                        ForEach(0..<volumes.count){
                            Text(volumes[$0])
                        }
                    }.pickerStyle(.automatic)
                }
                
                Section(header: Text("Result")){
                    Text("\(endVolumeAmount, specifier: "%.2g")")
                }
                
                
                
            }.navigationBarTitle("Volume Converter")
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

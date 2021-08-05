//
//  FilterView.swift
//  SortAndFilter
//
//  Created by Xun Ruan on 2021/8/1.
//

import SwiftUI

// Let user filter by age and country

struct FilterView: View {
    @EnvironmentObject var dataCollection: DataCollection
    @Environment(\.presentationMode) var presentationMode
    @State var countries = ["China", "Canada"]
    @State var selectedCountry = ""
    @State var ageFrom = ""
    @State var ageTo = ""
    
    var body: some View {
        NavigationView{
            VStack{
                Form{
                    Section(header: Text("Sort by country")){
                        Picker("\(selectedCountry)", selection: $selectedCountry){
                            ForEach(countries, id:\.self){
                                Text($0)
                            }
                        }
                    }
                    Section(header: Text("Sort by age")){
                        TextField("From", text: $ageFrom).keyboardType(.numberPad)
                        TextField("To", text: $ageTo).keyboardType(.numberPad)
                    }
                }
            }
            .navigationBarItems(trailing: Button("Save"){
                                    modifyData()
                                    self.presentationMode.wrappedValue.dismiss()})
            .navigationBarTitle(Text("Sort Condition"))
        }
    }
    
    func modifyData(){
        if selectedCountry != ""{
            dataCollection.userDisplayedMode = dataCollection.userDisplayedMode.filter{$0.country! == selectedCountry}
        }
        if ageFrom != ""{
            dataCollection.userDisplayedMode = dataCollection.userDisplayedMode.filter{$0.age! > Int(ageFrom)!}
        }
        
        if ageTo != ""{
            dataCollection.userDisplayedMode = dataCollection.userDisplayedMode.filter{$0.age! < Int(ageTo)!}
        }
            
            
        
    }
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView()
    }
}

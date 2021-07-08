//
//  AddView.swift
//  iExpense
//
//  Created by Xun Ruan on 2021-07-08.
//

import SwiftUI

// This view is to add an expense into our app
struct AddView: View {
    @State var name: String = ""
    @State var type: String = ""
    let types = ["Personal", "Business"]
    var amount: Int{
        Int(amountS) ?? 0
    }
    @State var amountS: String = ""
    
    @ObservedObject var expenses: Expenses
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    TextField("Item", text:$name)
                }
                
                Section(header: Text("Type")){
                    Picker("Type", selection:$type){
                        ForEach(types, id: \.self){
                            Text("\($0)")
                        }
                    }.pickerStyle(WheelPickerStyle())
                }
                
                Section{
                    TextField("Amount", text:$amountS).keyboardType(.numberPad)
                }
                
            }.navigationBarTitle(Text("Add new expense"))
        }
        
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}

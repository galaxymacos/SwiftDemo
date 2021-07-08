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
    @State var type: String = "Personal"
    let types = ["Personal", "Business"]
    @State var amountS: String = ""
    
    @ObservedObject var expenses: Expenses
    @Environment(\.presentationMode) var presentationMode
    
    @State var showAlert = false
    
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
                
            }
            .navigationBarTitle(Text("Add new expense"))
            .navigationBarItems(trailing: Button("Save"){
                if let actualAmount = (Int)(amountS){
                    expenses.items.append(ExpenseItem(name: name, type: type, amount: actualAmount))
                    presentationMode.wrappedValue.dismiss()
                }
                else{
                    showAlert = true
                }
            })
            .alert(isPresented: $showAlert){
                Alert(title: Text("Info wrong"), message: Text("Please correct your input"), dismissButton: .default(Text("Ok")))
            }
        }
        
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}

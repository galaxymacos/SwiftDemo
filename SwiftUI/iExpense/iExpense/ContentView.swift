//
//  ContentView.swift
//  iExpense
//
//  Created by Xun Ruan on 2021-07-07.
//

import SwiftUI
/*  using @ObservedObject
struct ContentView: View {
    
    class User: ObservableObject {
        @Published var firstName: String = ""
        @Published var lastName: String = ""
    }
    
    @ObservedObject var user = User()
    
    var body: some View {
        VStack{
            Text("Your name is \(user.firstName) \(user.lastName)")
            TextField("First name", text: $user.firstName)
            TextField("Last name", text: $user.lastName)
        }
    }
}
*/

/* showing the hiding views
 struct ContentView: View {
 @State var showSheet = false
 var body: some View{
 Button("Go to second view"){
 showSheet.toggle()
 }
 .sheet(isPresented: $showSheet, content: {
 SecondView(name: "galaxymaxx")
 })
 
 }
 }
 
 struct SecondView: View{
 @State var name: String
 @Environment(\.presentationMode) var presentationMode
 
 var body: some View{
 Button("Dismiss"){
 self.presentationMode.wrappedValue.dismiss()
 }
 }
 }
 
 */

/* Deleting items using onDelete()
 
 struct ContentView: View {
 @State var nums = [Int]()
 @State var currentNumber = 1
 
 var body: some View{
 
 NavigationView{
 
 VStack{
 List{
 ForEach(nums, id: \.self){
 Text("\($0)")
 }
 .onDelete(perform: removeRows)
 }
 Button("add number"){
 nums.append(currentNumber)
 currentNumber+=1
 }
 
 }
 .navigationBarItems(leading: EditButton())
 }
 
 
 }
 
 func removeRows(at offsets: IndexSet) {
 nums.remove(atOffsets: offsets)
 }
 
 }
 */

/*   Storing user settings with UserDefaults
 
 struct ContentView: View{
 @State var tapCount = UserDefaults.standard.integer(forKey: "Tap")
 var body: some View{
 Button("tap time: \(tapCount)"){
 self.tapCount+=1
 UserDefaults.standard.set(self.tapCount, forKey: "Tap")
 }
 }
 }
 */

/*  Archiving swift objects with Codable
 struct ContentView: View {
 struct User: Codable{
 var firstName:String
 var lastName:String
 }
 @State var user = User(firstName: "Taylor", lastName: "Swift")
 
 var body: some View{
 Button("button"){
 let encoder = JSONEncoder()
 // because encode may fail
 if let userData = try? encoder.encode(self.user){
 UserDefaults.standard.set(userData, forKey: "UserData")
 }
 }
 }
 }
 
 */


/*  Building a list we can delete from
    
 */

class Expenses: ObservableObject{
    @Published var items = [ExpenseItem](){
        didSet{
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(items){
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let items = UserDefaults.standard.data(forKey: "Items"){
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([ExpenseItem].self, from: items){
                self.items = decoded
                return
            }
        }
    }
    
}

struct ExpenseItem:Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Int
}

struct ContentView: View{
    
    
    
    
    @ObservedObject var expenses = Expenses()
    @State var showAddView = false

    
    var body: some View{
        NavigationView{
            List{
                ForEach(expenses.items){ item in
                    
                    HStack{
                        VStack(alignment: .leading) {
                                    Text(item.name)
                                        .font(.headline)
                                    Text(item.type)
                                }

                                Spacer()
                                Text("$\(item.amount)")
                                    .fontWeight(item.amount > 100 ? .bold : (item.amount > 10 ? .medium : .regular))
                                    .foregroundColor(item.amount>100 ? .red : (item.amount>10 ? .yellow : .blue))
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationBarItems(leading: EditButton(), trailing: Button(action:{
                showAddView = true
            }){
                Image(systemName: "plus")
            })
            
            .navigationTitle("iExpense")
            .edgesIgnoringSafeArea(.all)
        }
        .sheet(isPresented: $showAddView){
            AddView(expenses: expenses)
        }
        
    }
    
    func removeItems(for offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

//struct ContentView: View{
//    var body: some View{
//        Text("some text")
//    }
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

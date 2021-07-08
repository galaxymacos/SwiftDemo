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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

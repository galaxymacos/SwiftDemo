//
//  ContentView.swift
//  iExpense
//
//  Created by Xun Ruan on 2021-07-07.
//

import SwiftUI

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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

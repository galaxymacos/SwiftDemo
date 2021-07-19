//
//  ContentView.swift
//  HotProspects
//
//  Created by Xun Ruan on 2021/7/19.
//

import SwiftUI

class User: ObservableObject {
    @Published var name: String = ""
}

struct EditView: View {
    @EnvironmentObject var user: User
    var body: some View{
        TextField("name", text: $user.name)
    }
}

struct DisplayView: View {
    @EnvironmentObject var user: User
    var body: some View{
        Text("Name is \(user.name)")
    }
}

struct ContentView: View {
    let user = User()
    
    var body: some View {
        VStack{
            Form{
                EditView()
                DisplayView()
            }
        }
        .environmentObject(user)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

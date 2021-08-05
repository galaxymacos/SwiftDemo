//
//  ContentView.swift
//  MVVM
//
//  Created by Xun Ruan on 2021/7/29.
//

import SwiftUI

struct Person{
    var name: String
    var birthDate: Date
}

class ContentViewModel: ObservableObject{
    @Published private var person = Person(name: "Xun Ruan", birthDate: Date())
    
    var name: String{
        person.name
    }
    
    var age: String{
        // Perform Date-Age conversion
        return "32"
    }
    
    // Intent section
    func changeName(to name: String){
        person.name = name
    }
}

struct ContentView: View {
    
    @StateObject var contentView = ContentViewModel()
    var body: some View {
        VStack{
            Text("\(contentView.name)")
                .padding()
            Text("\(contentView.age)")
                .padding()
            Button("Change name"){
                contentView.changeName(to: "Bob")
            }
        }
        .font(.largeTitle)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  ContentView.swift
//  HotProspectsApp
//
//  Created by Xun Ruan on 2021/7/20.
//

import SwiftUI

class Prospect{
    let id = UUID()
    var name = ""
    var emailAddress = ""
    // Because modify this won't update UI, which will cause problem, so we stop others to modify it
    fileprivate(set) var isContacted = false
}

class Prospects: ObservableObject{
    // Published: SwiftUI will know when we add or remove a Prospect, but will not know if we secretly modify an element
    @Published var people: [Prospect]
    
    init() {
        people = []
    }
    
    func toggle(_ prospect: Prospect){
        // At the beginning because it will then handle the animation
        objectWillChange.send()
        prospect.isContacted.toggle()
    }
}

struct ContentView: View {
    var prospects = Prospects()
    
    var body: some View {
        TabView{
            ProspectsView(filter: .none)
                .tabItem {
                    Image(systemName: "person.3")
                    Text("Everyone")
            }
            ProspectsView(filter: .contacted)
                .tabItem {
                    Image(systemName: "checkmark.circle")
                    Text("Contacted")
            }
            ProspectsView(filter: .uncontacted)
                .tabItem {
                    Image(systemName: "questionmark.diamond")
                    Text("Uncontacted")
            }
            ProspectsView(filter: .contacted)
                .tabItem {
                    Image(systemName: "person.crop.square")
                    Text("Me")
            }
        }
        .environmentObject(prospects)
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

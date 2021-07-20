//
//  ContentView.swift
//  HotProspectsApp
//
//  Created by Xun Ruan on 2021/7/20.
//

import SwiftUI

class Prospect: Codable{
    var id = UUID()
    var name = ""
    var emailAddress = ""
    // Because modify this won't update UI, which will cause problem, so we stop others to modify it
    fileprivate(set) var isContacted = false
}

class Prospects: ObservableObject{
    // Published: SwiftUI will know when we add or remove a Prospect, but will not know if we secretly modify an element
    @Published private(set) var people: [Prospect]
    static let saveKey = "SavedData"
    
    init() {
        if let data = UserDefaults.standard.data(forKey: Prospects.saveKey){
            if let decoded = try? JSONDecoder().decode([Prospect].self, from: data){
                people = decoded
                return
            }
        }
        people = []
    }
    
    func toggle(_ prospect: Prospect){
        // At the beginning because it will then handle the animation
        objectWillChange.send()
        prospect.isContacted.toggle()
        Save()
    }
    
    private func Save() {
        if let data = try? JSONEncoder().encode(people){
            UserDefaults.standard.set(data, forKey: Prospects.saveKey)
        }
        
    }
    
    func add(_ prospect: Prospect) {
        people.append(prospect)
        Save()
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

//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Xun Ruan on 2021/7/13.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Wizard.entity(), sortDescriptors: []) var wizards: FetchedResults<Wizard>
    
    var body: some View{
        VStack{
            List(wizards, id: \.name){
                Text($0.name ?? "Unknown")
            }
            
            Button("Add"){
                // Add a new entity instance in core data
                let wizard = Wizard(context: moc)
                wizard.name = "Harry Potter"
            }
            
            
            Button("Save"){
                do{
                    try moc.save()
                }catch{
                    print(error.localizedDescription)
                }
            }
            
        }
        
    }
    
    func safeSave(){
        if moc.hasChanges{
            try? moc.save()
        }
    }
    
    func add() {
        let wizard = Wizard(context: moc)
        wizard.name = "Harry Potter"
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

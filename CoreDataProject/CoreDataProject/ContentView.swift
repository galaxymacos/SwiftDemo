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
    @FetchRequest(entity: Ship.entity(), sortDescriptors: [], predicate: NSPredicate(format: "universe == 'Star Trek'")) var ships: FetchedResults<Ship>
    @FetchRequest(entity: Ship.entity(), sortDescriptors: [], predicate: NSPredicate(format: "universe == %@", "Star Trek")) var ships2: FetchedResults<Ship>
    // Match results when the beginning letter less than a letter
    @FetchRequest(entity: Ship.entity(), sortDescriptors: [], predicate: NSPredicate(format: "universe < %@", "F")) var ship3: FetchedResults<Ship>
    
    // Match results if an element contains ...
    @FetchRequest(entity: Ship.entity(), sortDescriptors: [], predicate: NSPredicate(format: "name IN %@", ["Entreprise", "Defiant"])) var ships4: FetchedResults<Ship>
    
    @FetchRequest(entity: Ship.entity(), sortDescriptors: [], predicate: NSPredicate(format: "name BEGINSWITH[c] %@","e")) var ships5: FetchedResults<Ship>
    
    @FetchRequest(entity: Ship.entity(), sortDescriptors: [], predicate: NSPredicate(format: "name CONTAINS[c] %@", "e")) var ships6: FetchedResults<Ship>
    @State private var lastNameFilter = "A"
    
    @State private var showingALetterSinger = false
    @State private var showingSLetterSinger = false
    var body: some View{
        /* wizard related
         VStack{
         List(wizards, id: \.name){
         Text($0.name ?? "Unknown")
         }
         
         Button("Add"){
         // Add a new entity instance in core data
         let wizard = Wizard(context: moc)
         wizard.name = "Harry Potter"
         }
         
         //MARK
         Button("Save"){
         do{
         try moc.save()
         }catch{
         print(error.localizedDescription)
         }
         }
         
         }
         */
        
        /* Star ship
         VStack{
         List(ships, id: \.self){
         Text("\($0.name ?? "Unknown Ship") is in \($0.universe ?? "unknown universe")")
         }
         
         Button("Add"){
         let ship1 = Ship(context: moc)
         ship1.name = "Defiant"
         ship1.universe = "Star Trek"
         
         let ship2 = Ship(context: moc)
         ship2.name = "Entreprise"
         ship2.universe = "Star Trek"
         
         let ship3 = Ship(context: moc)
         ship3.name = "Millennium Falcon"
         ship3.universe = "Star Wars"
         
         let ship4 = Ship(context: moc)
         ship4.name = "Executor"
         ship4.universe = "Star Wars"
         
         safeSave()
         }
         }
         */
        VStack{
            Button("Add singer"){
                let taylor = Singer(context: self.moc)
                taylor.firstName = "Taylor"
                taylor.lastName = "Swift"
                
                let ed = Singer(context: self.moc)
                ed.firstName = "Ed"
                ed.lastName = "Sheeran"
                
                let adele = Singer(context: self.moc)
                adele.firstName = "Adele"
                adele.lastName = "Adkins"
                
                safeSave()
            }
            
            Button("Show A"){
                lastNameFilter  = "A"
                showingALetterSinger = true
            }.sheet(isPresented: $showingALetterSinger, content: {
//                FilteredList(filter: "A")
                FilteredListGenerics(filterKey: "lastName", filterValue: "A", content: { (singer: Singer) in
                    Text(singer.wrappedFirstName + " " + singer.wrappedLastName)
                })
            })
            
            Button("Show S"){
//                lastNameFilter = "S"
                showingSLetterSinger = true
            }.sheet(isPresented: $showingSLetterSinger, content: {
//                FilteredList(filter: "S")
                FilteredListGenerics(filterKey: "lastName", filterValue: "S", content: { (singer: Singer) in
                    Text(singer.wrappedFirstName + " " + singer.wrappedLastName)
                })
            })
            
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

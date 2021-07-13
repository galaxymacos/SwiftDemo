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
    
    var body: some View{
        Text("text")
    }
    
    func safeSave(){
        if moc.hasChanges{
            try? moc.save()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

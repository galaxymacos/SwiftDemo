//
//  PersistenceController.swift
//  TodosList
//
//  Created by Xun Ruan on 2021/7/26.
//

import CoreData

// Acts as a bridge between Core Data and SwiftUI
struct PersistenceController {
    // Singleton pattern in Swift
    // 
    static let shared = PersistenceController()
    
    // A container that encapsulate the Core Data stack in your app
    let container: NSPersistentContainer
    
    init(){
        // bind it with the only Core Data stack we have, but we haven't loaded
        container = NSPersistentContainer(name: "TodosList")
        
        // Load the core data stack
        container.loadPersistentStores{ (storeDescription, error) in
            if let error = error as NSError?{
                fatalError("Unsolved error: \(error.localizedDescription)")
            }
        }
    }
}

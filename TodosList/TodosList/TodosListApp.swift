//
//  TodosListApp.swift
//  TodosList
//
//  Created by Xun Ruan on 2021/7/13.
//

import SwiftUI

@main
struct TodosListApp: App {
    let persistenceContainer = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceContainer.container.viewContext)
        }
    }
}

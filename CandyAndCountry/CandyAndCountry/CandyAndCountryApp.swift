//
//  CandyAndCountryApp.swift
//  CandyAndCountry
//
//  Created by Xun Ruan on 2021/7/14.
//

import SwiftUI

@main
struct CandyAndCountryApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

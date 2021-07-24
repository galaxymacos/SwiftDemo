//
//  StudyCardsApp.swift
//  StudyCards
//
//  Created by Xun Ruan on 2021/7/23.
//

import SwiftUI
import Firebase

@main
struct StudyCardsApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            CardListView(cardListViewModel: CardListViewModel())
        }
    }
}

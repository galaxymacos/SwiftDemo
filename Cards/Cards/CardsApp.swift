//
//  CardsApp.swift
//  Cards
//
//  Created by 阮迅 on 2021-09-29.
//

import SwiftUI

@main
struct CardsApp: App {
    
    @StateObject var viewState = ViewState()
    
    var body: some Scene {
        WindowGroup {
            CardsView()
                .environmentObject(viewState)
        }
    }
}

//
//  ContentView.swift
//  LearnShortcut
//
//  Created by Xun Ruan on 2021/8/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello world")
            .font(.title)
            .fontWeight(.regular)
            .foregroundColor(Color.red)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ContentView_LibraryContent: LibraryContentProvider {
    
    // Add custom views
    var views: [LibraryItem] {
        LibraryItem(
            Circle().foregroundColor(.green),
            title: "Green Circle",
            category: .control
        )
        
        LibraryItem(
            Rectangle().foregroundColor(.red),
            title: "Red Square",
            category: .control
        )
    }
    
    // Add custom view modifiers
    @LibraryContentBuilder
    func modifiers<View: SwiftUI.View>(base: View) -> [LibraryItem] {
        LibraryItem(
            base.opacity(0.2),
            title: "Ghostly",
            category: .effect
        )
        
    }
}

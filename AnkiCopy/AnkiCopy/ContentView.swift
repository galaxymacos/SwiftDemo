//
//  ContentView.swift
//  AnkiCopy
//
//  Created by Xun Ruan on 2021/7/21.
//

import SwiftUI


struct ContentView: View {
    var body: some View {
        CardView(card: Card.example)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

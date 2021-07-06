//
//  ContentView.swift
//  WordScramble
//
//  Created by Xun Ruan on 2021-07-06.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack{
            List(0..<5){
                Text("Test \($0)")
            }
            
            List(0..<5){
                Text("Test \($0)").font(.title)
            }.listStyle(GroupedListStyle())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Xun Ruan on 2021/7/25.
//

import SwiftUI

struct NavigationviewDifferentBehavioriPhoneiPad: View {
    var body: some View {
        NavigationView{
            Text("Hello world")
                .navigationTitle("Primary")
            
            Text("Secondary")
        }
    }
}

struct ContentView: View {
    var body: some View{
        NavigationView{
            NavigationLink(destination: Text("Second text")){
                Text("First View")
            }
            .navigationBarTitle("Primary")
            
            // This won't be shown
            Text("Second View")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

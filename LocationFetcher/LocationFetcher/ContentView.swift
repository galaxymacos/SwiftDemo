//
//  ContentView.swift
//  LocationFetcher
//
//  Created by Xun Ruan on 2021/7/18.
//

import SwiftUI

struct ContentView: View {
    let locationFetcher = LocationFetcher()
    var body: some View {
        VStack{
            Button("Asking for location"){
                locationFetcher.Start()
            }
            
            Button("User's location"){
                if let lastKnownLocation = locationFetcher.lastKnownLocation{
                    print("Your last known location is \(lastKnownLocation)")
                }
                else{
                    print("Unknown")
                }
            }
        }
            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

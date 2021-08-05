//
//  ContentView.swift
//  HitTesting
//
//  Created by Xun Ruan on 2021/7/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack{
            Rectangle()
                .fill(Color.blue)
                .frame(width: 300, height: 300)
                .onTapGesture{
                    print("Rectangle tapped")
                }
            
            Circle()
                .fill(Color.red)
                .frame(width: 300, height: 300)
                // Allow user to click the frame to trigger
//                .contentShape(Rectangle())
                .onTapGesture {
                    print("Circle tapped")
                }
                // Stop the circle from being detected
                .allowsHitTesting(false)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

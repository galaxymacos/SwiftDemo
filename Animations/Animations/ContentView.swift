//
//  ContentView.swift
//  Animations
//
//  Created by Xun Ruan on 2021-07-07.
//

import SwiftUI

struct ContentView: View {
    @State var animationAmount: CGFloat = 1
    var body: some View {
        VStack{
            Button("Tap me"){
                animationAmount += 1
            }
            .padding(50)
            .foregroundColor(.white)
            .background(Color.red)
            .clipShape(Circle())
            .scaleEffect(animationAmount)
            .animation(.default)
            .blur(radius: (animationAmount - 1) * 3)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

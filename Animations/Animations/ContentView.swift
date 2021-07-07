//
//  ContentView.swift
//  Animations
//
//  Created by Xun Ruan on 2021-07-07.
//

import SwiftUI

struct ContentView: View {
    @State private var animationAmount: CGFloat = 1
    struct MyButton: View {
        @Binding var animationAmount: CGFloat
        var body: some View{
            Button("Tap me"){
                self.animationAmount += 1
            }
            .padding(40)
            .background(Color.red)
            .foregroundColor(.white)
            .clipShape(Circle())
            .scaleEffect(animationAmount)
            
        }
    }
    
    var body: some View {
        VStack {
            Stepper("Scale amount", value: $animationAmount.animation(), in: 1...10)

            Spacer()

            MyButton(animationAmount: $animationAmount)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

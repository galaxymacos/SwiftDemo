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
            print(animationAmount)
            return VStack{
                Button("Tap me"){
                    self.animationAmount += 1
                }
                .padding(40)
                .background(Color.red)
                .foregroundColor(.white)
                .clipShape(Circle())
                // Change scaleEffect() without animation() will not trigger animation
                .scaleEffect(animationAmount)
//                .animation(
//                            Animation.easeInOut(duration: 1).repeatCount(3, autoreverses: true))
            }
            
        }
    }
    
    var body: some View {
        VStack {
            Stepper("Scale amount", value: $animationAmount, in: 1...10)

            MyButton(animationAmount: $animationAmount)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

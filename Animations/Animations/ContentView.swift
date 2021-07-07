//
//  ContentView.swift
//  Animations
//
//  Created by Xun Ruan on 2021-07-07.
//

import SwiftUI



struct ContentView: View {
    @State var animationValue: CGFloat = 1

    struct RedRoundButton: View{
        @Binding var animationValue: CGFloat
        var body: some View{
            Button("Tap me"){
                animationValue += 1
            }
            .padding(50)
            .foregroundColor(.white)
            .background(Color.accentColor)
            .clipShape(Circle())
            .scaleEffect(animationValue)
        }
    }
    
    struct RedRoundButtonWithoutScalingEffect: View{
        @Binding var animationValue: CGFloat
        var body: some View{
            Button("Tap me"){
                animationValue += 1
            }
            .padding(50)
            .foregroundColor(.white)
            .background(Color.accentColor)
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(Color.red)
                    .scaleEffect(animationValue)
                    .opacity(Double(2 - animationValue))
            )
        }
    }
    
    struct OverlayEffect: ViewModifier{
        @Binding var animationValue: CGFloat
        func body(content: Content) -> some View {
            content
                .overlay(
                    Circle()
                        .stroke(Color.red)
                        .scaleEffect(animationValue)
                        .opacity(Double(2 - animationValue))
                        .animation(
                            Animation.easeOut(duration: 1)
                                .repeatForever(autoreverses: false)
                        )
                )
        }
    }
    
    struct ScalingEffect: ViewModifier{
        @Binding var animationValue: CGFloat
        func body(content: Content) -> some View {
            content
                .scaleEffect()
        }
    }
    
    var body: some View{
        VStack{
//            RedRoundButton(animationValue: $animationValue.animation())
            
//            RedRoundButton(animationValue: $animationValue.animation(.easeOut))
            
//            RedRoundButton(animationValue: $animationValue.animation(.interpolatingSpring(stiffness: 50, damping: 1)))
            
//            RedRoundButton(animationValue: $animationValue.animation(.easeInOut(duration: 0.25)))
            
//            RedRoundButton(animationValue: $animationValue.animation(.easeInOut(duration: 0.25).delay(1)))
            
//            RedRoundButton(animationValue: $animationValue.animation(.easeInOut(duration: 0.25).repeatCount(3, autoreverses: true)))
            
//            RedRoundButton(animationValue: $animationValue.animation(.easeInOut(duration: 0.25).repeatForever(autoreverses: false)))
            
//            RedRoundButton(animationValue: $animationValue.animation())
            
//            RedRoundButtonWithoutScalingEffect(animationValue: $animationValue.animation())
            
            // TODO figure out why it can't auto loop the animation on startup
//            RedRoundButtonWithoutScalingEffect(animationValue: $animationValue.animation(.easeOut(duration: 1).repeatForever(autoreverses: false)))
            
            
//            RedRoundButton(animationValue: $animationValue.animation()).modifier(OverlayEffect(animationValue: $animationValue))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}




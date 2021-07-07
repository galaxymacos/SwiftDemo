//
//  ContentView.swift
//  Animations
//
//  Created by Xun Ruan on 2021-07-07.
//

import SwiftUI



//struct ContentView: View {
//    @State private var animationAmount = 0.0
//
//    var body: some View{
//        Button("tap me"){
//            withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)){
//                self.animationAmount += 360
//            }
//
//            withAnimation(){
//                self.animationAmount += 360
//            }
//        }
//        .padding(50)
//        .foregroundColor(.white)
//        .background(Color.red)
//        .clipShape(Circle())
//        .rotation3DEffect(
//            .degrees(animationAmount),
//            axis: (x: 0.0, y: 1.0, z: 0.0)
//        )
//    }
//}

// Controlling the animation stack
struct ContentView: View {
    @State var darkMode = false
    
    var body: some View{
        VStack{
            Button("Tap"){
                darkMode.toggle()
            }
            .padding(50)
            .background(darkMode ? Color.black : Color.red)
            // You can disable animation so that the modifier above this animation has no animation
            .animation(nil)
            .foregroundColor(darkMode ? .black : .white)
            .clipShape(Circle())
            .scaleEffect(darkMode ? 2 : 1)
            .animation(.default)
            .rotation3DEffect(
                .degrees(darkMode ? 180: 0),
                axis: (x: 0.0, y: 1.0, z: 0.0)
            )
            .animation(.easeOut)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        ContentView()
    }
}



//

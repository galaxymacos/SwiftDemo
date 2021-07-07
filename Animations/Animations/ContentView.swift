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
//struct ContentView: View {
//    @State var darkMode = false
//
//    var body: some View{
//        VStack{
//            Button("Tap"){
//                darkMode.toggle()
//            }
//            .padding(50)
//            .background(darkMode ? Color.black : Color.red)
//            // You can disable animation so that the modifier above this animation has no animation
//            .animation(nil)
//            .foregroundColor(darkMode ? .black : .white)
//            .clipShape(Circle())
//            .scaleEffect(darkMode ? 2 : 1)
//            .animation(.default)
//            .rotation3DEffect(
//                .degrees(darkMode ? 180: 0),
//                axis: (x: 0.0, y: 1.0, z: 0.0)
//            )
//            .animation(.easeOut)
//        }
//    }
//}

//struct ContentView: View{
//    @State var dragAmount: CGSize = CGSize.zero
//
//    var body: some View{
//        LinearGradient(gradient: Gradient(colors:[.black, .white]), startPoint: .topLeading, endPoint: .bottomTrailing)
//            .frame(width: 300, height: 400)
//            .clipShape(RoundedRectangle(cornerRadius: 25.0))
//            .offset(dragAmount)
//            .gesture(
//            DragGesture()
//                .onChanged{self.dragAmount = $0.translation}
//                .onEnded{_ in
//                    withAnimation{
//                        self.dragAmount = CGSize.zero
//                    }
//                }
//            )
//    }
//}


// Intersting animation
/**
 struct ContentView: View {
 let letters = Array("Hello SwiftUI")
 @State private var enabled = false
 @State private var dragAmount = CGSize.zero
 
 var body: some View {
 HStack(spacing: 0) {
 ForEach(0..<letters.count) { num in
 Text(String(self.letters[num]))
 .padding(5)
 .font(.title)
 .background(self.enabled ? Color.blue : Color.red)
 .offset(self.dragAmount)
 .animation(Animation.default.delay(Double(num) / 20))
 }
 }
 .gesture(
 DragGesture()
 .onChanged { self.dragAmount = $0.translation }
 .onEnded { _ in
 self.dragAmount = .zero
 self.enabled.toggle()
 }
 )
 }
 }
 
 */

struct ContentView:View {
    @State private var isShowingRed = false
    var body: some View{
        VStack{
            Button("Tap me"){
                withAnimation{
                    
                    self.isShowingRed.toggle()
                }
            }
            
            if(isShowingRed){
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 200, height: 200)
//                    .transition(.scale)
                    .transition(.asymmetric(insertion: .scale, removal: .opacity))
            }
                
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        ContentView()
    }
}



//

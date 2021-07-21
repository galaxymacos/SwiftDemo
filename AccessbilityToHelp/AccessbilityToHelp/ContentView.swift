//
//  ContentView.swift
//  AccessbilityToHelp
//
//  Created by Xun Ruan on 2021/7/21.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityReduceMotion) var reduceMotion
    @Environment(\.accessibilityReduceTransparency) var reduceTransparency
    @State var scale:CGFloat = 1
    
    var body: some View {
        VStack(spacing: 30){
            HStack{
                if differentiateWithoutColor{
                    Image(systemName: "checkmark.circle")
                }
                Text("Success")
                    .padding()
                    .foregroundColor(.white)
                    .background(differentiateWithoutColor ? Color.black : Color.green)
                    .clipShape(Capsule())
            }

            Text("Tap to scale")
                .scaleEffect(scale)
                .onTapGesture {
                    if reduceMotion{
                        self.scale *= 1.5
                    }
                    else{
                        withAnimation{
                            self.scale *= 1.5
                        }
                    }
                    
                    // 高级写法
                    withOptionalAnimation{
                        self.scale *= 1.5
                    }
                }
            
            Text("Reduce transparency")
                .padding()
                .foregroundColor(.white)
                .background(reduceTransparency ? Color.black : Color.black.opacity(0.5))
                .clipShape(Capsule())
                
        }
    }
    
    func withOptionalAnimation<Result>(_ animation: Animation = .default, body: () throws -> Result) rethrows -> Result{
        if UIAccessibility.isReduceMotionEnabled{
            return try body()
        }
        else{
            return try withAnimation(animation, body)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  ContentView.swift
//  View composition
//
//  Created by Xun Ruan on 2021/7/4.
//

import SwiftUI


struct ContentView: View {
    
    var body: some View{
        ZStack{
            Color.blue
            frame(width: 300, height: 300)
        }.edgesIgnoringSafeArea(.all).waterMark(with: "watermark")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 15.0, *) {
            ContentView()
                .previewInterfaceOrientation(.landscapeLeft)
        } else {
            // Fallback on earlier versions
        }
    }
}

//
//  Ext_View.swift
//  ViewsAndModifiers
//
//  Created by Xun Ruan on 2021/7/5.
//

import Foundation
import SwiftUI

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding()
            .background(Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct WaterMark: ViewModifier{
    var text: String
    
    func body(content: Content) -> some View{
        ZStack(alignment: .bottomTrailing){
            content
            Text(text)
                .font(.caption)
                .foregroundColor(.white)
                .padding(5)
                .background(Color.black)
        }
    }
}

extension View {
    func titleStyle() -> some View {
        self.modifier(Title())
    }
    
    func waterMark(with text: String) -> some View {
        self.modifier(WaterMark(text: text))
    }
}



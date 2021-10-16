//
//  ContentView.swift
//  MovieCarousol
//
//  Created by 阮迅 on 2021-10-16.
//

import SwiftUI

struct ContentView: View {
    
    func getScale(proxy: GeometryProxy) -> CGFloat {
        var scale: CGFloat = 1
        let x = proxy.frame(in: .global).minX
        let diff = abs(x)
        if diff < 100 {
            scale = 1 + (100 - diff) / 500
        }
        return scale
    }
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                ScrollView(.horizontal) {
                    HStack(alignment: .center, spacing: 50) {
                        ForEach(0..<20) { num in
                            NavigationLink(destination: Image("WonderWomen").resizable().scaledToFill()) {
                                GeometryReader { proxy in
                                    VStack {
                                        Image("WonderWomen")
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 150)
                                            .clipped()
                                            .cornerRadius(5)
                                            .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 0.5))
                                            .shadow(radius: 5)
                                            .scaleEffect(getScale(proxy: proxy))
                                            .animation(.easeOut(duration: 0.5))
                                        Text("Wonder Women 1984")
                                            .padding(.top)
                                            .multilineTextAlignment(.center)
                                            .foregroundColor(.black)
                                    }
                                }
                            }
                            .frame(width: 125, height: 300)
                            
                        }
                    }
                    .padding(32)
                }
            }
            .navigationTitle("Movie Carousol")
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

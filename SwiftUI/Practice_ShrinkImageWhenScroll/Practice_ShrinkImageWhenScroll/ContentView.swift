//
//  ContentView.swift
//  Practice_ShrinkImageWhenScroll
//
//  Created by Xun Ruan on 2021/7/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GeometryReader{fullView in
            ScrollView{
                VStack{
                    ForEach(1..<50){index in
                        GeometryReader{ geo in
                            Image(systemName: "plus")
                                .scaleEffect(geo.frame(in: .global).midY / fullView.size.height + 0.6 < 0.8 ? 0.8 : geo.frame(in: .global).midY / fullView.size.height + 0.6)
                                .padding()
                        }
                        .frame(width: 50, height: 50, alignment: .center)
                    }
                }
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

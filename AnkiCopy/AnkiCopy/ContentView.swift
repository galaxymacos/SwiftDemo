//
//  ContentView.swift
//  AnkiCopy
//
//  Created by Xun Ruan on 2021/7/21.
//

import SwiftUI

extension View{
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = total - position
        return self.offset(x: 0, y: CGFloat(offset * 10))
    }
}

struct ContentView: View {
    @State var cards = [Card](repeating: Card.example, count: 10)
    
    
    var body: some View {
        ZStack{
            Image("background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            ForEach(0..<cards.count, id: \.self){ index in
                CardView(card: Card.example)
                    .stacked(at: index, in: cards.count)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Xun Ruan on 2021/7/22.
//

import SwiftUI

/* Introduction
 struct ContentView: View {
 var body: some View {
 Text("Hello, world!")
 .padding()
 .background(Color.red)
 }
 }
 */

struct ContentView: View{
    var body: some View{
//        Text("Live long and prosper")
//            .frame(width: 300, height: 300, alignment: .topLeading)
        
//        HStack(alignment: .lastTextBaseline){
//            Text("live")
//                .font(.caption)
//            Text("long")
//            Text("and")
//                .font(.title)
//            Text("prosper")
//                .font(.largeTitle)
//        }
        
        // change what position is counted as its '.leading'
        VStack(alignment: .leading) {
            Text("Hello, world!")
                .alignmentGuide(.leading) { d in d[.trailing] }
            Text("This is a longer line of text")
        }
        
        // More example of alignmentGuide
//        VStack(alignment: .leading) {
//            ForEach(0..<10) { position in
//                Text("Number \(position)")
//                    // change its .leading position to be CGFloat(position)*10 pixel to the left
//                    .alignmentGuide(.leading) { _ in CGFloat(position) * -10 }
//            }
//        }
//        .background(Color.red)
//        .frame(width: 400, height: 400)
//        .background(Color.blue)
        
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

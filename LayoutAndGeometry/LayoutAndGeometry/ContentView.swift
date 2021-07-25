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

/* Alignment guide
 struct ContentView: View{
 var body: some View{
 Text("Live long and prosper")
 .frame(width: 300, height: 300, alignment: .topLeading)
 
 HStack(alignment: .lastTextBaseline){
 Text("live")
 .font(.caption)
 Text("long")
 Text("and")
 .font(.title)
 Text("prosper")
 .font(.largeTitle)
 }
 
 // change what position is counted as its '.leading'
 VStack(alignment: .leading) {
 Text("Hello, world!")
 .alignmentGuide(.leading) { d in d[.trailing] }
 Text("This is a longer line of text")
 }
 
 // More example of alignmentGuide
 VStack(alignment: .leading) {
 ForEach(0..<10) { position in
 Text("Number \(position)")
 // change its .leading position to be CGFloat(position)*10 pixel to the left
 .alignmentGuide(.leading) { _ in CGFloat(position) * -10 }
 }
 }
 .background(Color.red)
 .frame(width: 400, height: 400)
 .background(Color.blue)
 
 
 }
 
 }
 */

/* Custom alignment guide
 struct ContentView: View{
 var body: some View{
 HStack(alignment: .midAccountAndName) {
 VStack {
 Text("@twostraws")
 .alignmentGuide(.midAccountAndName){d in d[VerticalAlignment.center]
 }
 Image("paul-hudson")
 .resizable()
 .frame(width: 64, height: 64)
 }
 
 VStack {
 Text("Full name:")
 Text("PAUL HUDSON")
 .font(.largeTitle)
 .alignmentGuide(.midAccountAndName){d in d[VerticalAlignment.center]
 }
 }
 }
 }
 }
 
 extension VerticalAlignment {
 enum MidAccountAndName: AlignmentID {
 static func defaultValue(in d: ViewDimensions) -> CGFloat {
 d[.top]
 }
 }
 
 static let midAccountAndName = VerticalAlignment(MidAccountAndName.self)
 }
 */

/* Absolute positioning for swiftUI views
 struct ContentView: View{
 var body: some View{
 //        Text("Hello world")
 // .position needs to use full space to know the position, that's why the background is covered in full space
 //            .position(x: 0, y: 0)
 //            .background(Color.red)
 
 Text("Hello world")
 // offset won't change its actual position
 .offset(x: 100, y: 100)
 .background(Color.red)
 }
 }
 */

/* Geometry reader will take up remaining space unless provided with a frame
 struct ContentView: View{
 var body: some View{
 //        GeometryReader{ geo in
 //            Text("Hello world")
 //                .frame(width: geo.size.width * 0.9)
 //                .background(Color.red)
 //        }
 
 VStack {
 GeometryReader { geo in
 Text("Hello, World!")
 .frame(width: geo.size.width * 0.9, height: 50)
 .background(Color.red)
 }
 // GeometryReader has a preferred size that will take all the remaining space
 .background(Color.green)
 
 Text("More text")
 .background(Color.blue)
 }
 }
 }
 */

struct OuterView: View {
    var body: some View {
        VStack {
            Text("Top")
            InnerView()
                .background(Color.green)
            Text("Bottom")
        }
    }
}

struct InnerView: View {
    var body: some View {
        HStack {
            // Views in a HStack or a VStack will have its size the same with the largest element that takes up the most space
            Text("Left")
            GeometryReader { geo in
                Text("Center")
                    .background(Color.blue)
                    .onTapGesture {
                        // the (x:,y:) relative the top-left corner of the screen
                        print("Global center: \(geo.frame(in: .global).midX) x \(geo.frame(in: .global).midY)")
                        
                        // the (x:,y:) relative the top-left corner of what holds the name of "custom" coordinate space (In this case, it's the OuterView
                        print("Custom center: \(geo.frame(in: .named("Custom")).midX) x \(geo.frame(in: .named("Custom")).midY)")
                        // the (x:,y:) relative to the top-left corner of its parent (in this case, it is the grometry reader
                        print("Local center: \(geo.frame(in: .local).midX) x \(geo.frame(in: .local).midY)")
                    }
            }
            .background(Color.orange)
            Text("Right")
        }
    }
}

struct ContentView: View {
    var body: some View {
        OuterView()
            .background(Color.red)
            .coordinateSpace(name: "Custom")
    }
}
/* Understanding frames and coordinates insides GrometryReader
 */

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

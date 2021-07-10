//
//  ContentView.swift
//  Drawing
//
//  Created by Xun Ruan on 2021/7/9.
//

import SwiftUI

/*  Using custom path
 struct ContentView: View {
 var body: some View {
 Path{ path in
 path.move(to: CGPoint(x: 200, y: 100))
 path.addLine(to: CGPoint(x:100, y:300))
 path.addLine(to: CGPoint(x:300, y:300))
 path.addLine(to: CGPoint(x:200, y:100))
 // This happens because SwiftUI makes sure lines connect up neatly with what comes before and after rather than just being a series of individual lines, but our last line has nothing after it so there’s no way to make a connection.
 path.addLine(to: CGPoint(x:100, y:300))
 }
 //        .fill(Color.blue.opacity(0.25))
 //        .stroke(Color.blue, lineWidth: 10)
 .stroke(Color.blue, style: StrokeStyle(lineWidth: 10, lineCap: .round,lineJoin: .round))
 }
 }
 */

/* Path vs shape
 struct ContentView: View {
 struct Triangle: Shape {
 func path(in rect: CGRect) -> Path {
 var path = Path()
 path.move(to: CGPoint(x: rect.midX, y: rect.minY))
 path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
 path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
 path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
 return path
 }
 }
 
 struct Arc: Shape {
 let startAngle: Angle
 let endAngle: Angle
 let closeWise: Bool
 
 func path(in rect: CGRect) -> Path {
 var path = Path()
 path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: 100, startAngle: startAngle-Angle.degrees(90), endAngle: endAngle-Angle.degrees(90), clockwise: !closeWise)
 return path
 }
 }
 
 var body: some View{
 VStack{
 Triangle()
 //            .fill(Color.blue)
 .stroke(Color.red, style: StrokeStyle(lineWidth: 10, lineCap: .round))
 .frame(width: 200, height: 200)
 Arc(startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 200), closeWise: true)
 .fill(Color.green)
 .frame(width: 200, height: 200)
 }
 }
 }
 */

/*  make arc insettable shape
 struct ContentView: View{
 
 struct Arc: InsettableShape {
 let startAngle: Angle
 let endAngle: Angle
 let closeWise: Bool
 
 var insetAmount: CGFloat = 0
 
 func path(in rect: CGRect) -> Path {
 var path = Path()
 path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width/2 - insetAmount, startAngle: startAngle-Angle.degrees(90), endAngle: endAngle-Angle.degrees(90), clockwise: !closeWise)
 return path
 }
 
 // This method will be called whenever we try to shrink the shape
 func inset(by amount: CGFloat) -> some InsettableShape {
 // self is immutable, so we need a copy of self
 var arc = self
 arc.insetAmount += amount
 return arc
 
 //            self.insetAmount += amount
 //            return self
 }
 }
 
 var body: some View{
 
 
 
 VStack{
 Circle()
 //            .stroke(Color.blue, style: StrokeStyle(lineWidth: 30))
 // The strike will be drawn inside the circle
 .strokeBorder(Color.purple, lineWidth: 40)
 
 Arc(startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 360), closeWise: true)
 .strokeBorder(Color.orange, lineWidth: 30)
 
 }
 }
 }
 */

/* Using CGAffineTransform and even-odd fill to draw
 struct Flower: Shape {
 // How much to move this petal away from the center
 var petalOffset: Double = -20
 
 // How wide to make each petal
 var petalWidth: Double = 100
 
 func path(in rect: CGRect) -> Path {
 // The path that will hold all petals
 var path = Path()
 
 // Count from 0 up to pi * 2, moving up pi / 8 each time
 for number in stride(from: 0, to: CGFloat.pi * 2, by: CGFloat.pi / 8) {
 
 // rotate the petal by the current value of our loop
 let rotation = CGAffineTransform(rotationAngle: number)
 
 // move the petal to be at the center of our view
 let position = rotation.concatenating(CGAffineTransform(translationX: rect.width / 2, y: rect.height / 2))
 
 // create a path for this petal using our properties plus a fixed Y and height
 let originalPetal = Path(ellipseIn: CGRect(x: CGFloat(petalOffset), y: 0, width: CGFloat(petalWidth), height: rect.width / 2))
 
 // apply our rotation/position transformation to the petal
 let rotatedPetal = originalPetal.applying(position)
 
 // add it to our main path
 path.addPath(rotatedPetal)
 }
 
 // now send the main path back
 return path
 }
 }
 
 struct ContentView: View {
 @State private var petalOffset = -20.0
 @State private var petalWidth = 100.0
 
 var body: some View {
 VStack {
 Flower(petalOffset: petalOffset, petalWidth: petalWidth)
 //                .stroke(Color.red, lineWidth: 1)
 .fill(Color.blue, style: FillStyle(eoFill: true))
 
 
 Text("Offset")
 Slider(value: $petalOffset, in: -40...40)
 .padding([.horizontal, .bottom])
 
 Text("Width")
 Slider(value: $petalWidth, in: 0...100)
 .padding(.horizontal)
 }
 }
 }
 */

struct ContentView: View {
    var body: some View{
        VStack{
            
            Text("Hello world")
                .frame(width: 300, height: 300)
                //            .border(ImagePaint(image: Image("AirMaxPreDay"), scale: 0.5), width: 30)
                .border(ImagePaint(image: Image("AirMaxPreDay"),sourceRect: CGRect(x: 0, y: 0.25, width: 1, height: 0.5), scale:0.5), width: 30)
            
            Capsule()
//                .fill(ImagePaint(image: Image("AixMaxPreDay")))
                .strokeBorder(ImagePaint(image: Image("AirMaxPreDay")), lineWidth: 20)
                .frame(width: 300, height: 200)
            
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

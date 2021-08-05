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

/*  Creative border using ImagePaint
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
 */

/* Color circling circle
 struct ColorCirclingCircle: View {
 var amount = 0.0
 var steps = 0
 
 var body: some View {
 ZStack {
 ForEach(0..<steps) { value in
 Circle()
 .inset(by: CGFloat(value))
 //                        .strokeBorder(self.color(for: value, brightness: 1), lineWidth: 2)
 .strokeBorder(LinearGradient(gradient: Gradient(colors: [
 self.color(for: value, brightness: 1),
 self.color(for: value, brightness: 0.5)
 ]), startPoint: .top, endPoint: .bottom), lineWidth: 2)
 }
 }
 // This tells SwiftUI it should render the contents of the view into an off-screen image before putting it back onto the screen as a single rendered output, which is signficantly faster.
 // Adding the off-screen render pass might slow down SwiftUI for simple drawing, so you should wait until you have an actual performance problem before trying to bring in drawingGroup().
 .drawingGroup()
 }
 
 func color(for value: Int, brightness: Double)->Color{
 var hue = Double(value)/(Double)(self.steps) + self.amount
 if hue > 1 {
 hue -= 1
 }
 return Color(hue: hue, saturation: 1, brightness: brightness)
 }
 }
 struct ContentView:View {
 @State var amount:Double = 0
 var body: some View{
 VStack{
 ColorCirclingCircle(amount: self.amount, steps: 100)
 
 Slider(value: $amount, in: 0...1)
 }
 }
 }
 */

/* blendMode
 struct ContentView: View {
 var body: some View{
 VStack{
 ZStack{
 Image("Example")
 .resizable()
 
 Rectangle()
 .fill(Color.red)
 .blendMode(.multiply)
 }
 .frame(width: 400, height: 400)
 .clipped()
 
 Image("Example")
 .resizable()
 .colorMultiply(.blue)
 .frame(width:400, height: 400)
 
 
 }
 }
 }
 */

/* blendmode .screen
 struct ContentView: View {
 @State var amount: CGFloat = 0
 
 var body: some View {
 VStack{
 ZStack{
 Circle()
 .fill(Color(red: 0, green: 0, blue: 1))
 .frame(width: 200, height: 200)
 .offset(x: -50, y: 0)
 .blendMode(.screen)
 
 Circle()
 .fill(Color(red: 0, green: 1, blue: 0))
 .frame(width: 200, height: 200)
 .offset(x: 50, y: 0)
 .blendMode(.screen)
 
 Circle()
 .fill(Color(red: 1, green: 0, blue: 0))
 .frame(width: 200)
 .offset(x: 0, y: 80)
 .blendMode(.screen)
 }
 .frame(width: 400, height: 400)
 
 Slider(value: $amount, in: 0...200)
 .padding()
 }
 .frame(maxWidth: .infinity, maxHeight: .infinity)
 .background(Color.black)
 .edgesIgnoringSafeArea(.all)
 
 }
 
 }
 */

/* blurs, blending and saturation
 struct ContentView:View {
 @State var amount: CGFloat = 0
 var body: some View{
 VStack{
 Image("AirMaxPreDay")
 .resizable()
 .scaledToFit()
 .frame(width: 200, height: 200)
 // saturation = 0 means no color, saturation = 1 means original color
 .saturation(Double(amount))
 .blur(radius: (1-amount) * 10)
 
 Slider(value: $amount, in: 0...1)
 .padding()
 }
 }
 }
 */

/* animatableData
 struct Trapezoid: Shape {
 var insetAmount: CGFloat
 
 
 // Allow swift to slowly set the value by intepolating
 var animatableData: CGFloat {
 get{ insetAmount }
 set{ self.insetAmount = newValue }
 }
 
 func path(in rect: CGRect) -> Path {
 var path = Path()
 
 path.move(to: CGPoint(x: 0, y: rect.maxY))
 path.addLine(to: CGPoint(x: insetAmount, y: rect.minY))
 path.addLine(to: CGPoint(x: rect.maxX - insetAmount, y: rect.minY))
 path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
 path.addLine(to: CGPoint(x: 0, y: rect.maxY))
 
 return path
 }
 }
 
 struct ContentView: View {
 @State var insetAmount:CGFloat = 50
 
 
 
 var body: some View{
 VStack{
 Trapezoid(insetAmount: insetAmount)
 .frame(width: 200, height: 100)
 .onTapGesture {
 withAnimation{
 self.insetAmount = CGFloat.random(in: 10...90)
 }
 }
 
 Slider(value:$insetAmount, in: 0...100)
 .padding()
 }
 }
 
 }
 */

/* CheckerBoard
 
 struct CheckerBoard: Shape {
 var numofRows: Int
 var numofColumns: Int
 
 var animatableData: AnimatablePair<Double, Double>{
 get{ AnimatablePair(Double(numofRows), Double(numofColumns)) }
 set{
 self.numofRows = Int(newValue.first)
 self.numofColumns = Int(newValue.second)
 }
 
 }
 
 func path(in rect: CGRect) -> Path {
 var path = Path()
 let sizeofRow = rect.height / CGFloat(numofRows)
 let sizeofCol = rect.width / CGFloat(numofColumns)
 
 for row in 0..<numofRows {
 for col in 0..<numofColumns {
 if(row + col).isMultiple(of: 2){
 let startX = CGFloat(col) * sizeofCol
 let startY = CGFloat(row) * sizeofRow
 let rect = CGRect(x: startX, y: startY, width: sizeofCol, height: sizeofRow)
 path.addRect(rect)
 }
 }
 }
 return path
 }
 }
 
 struct ContentView: View{
 @State var numofRows = 8
 @State var numofCols = 8
 var body: some View{
 CheckerBoard(numofRows: numofRows, numofColumns: numofCols)
 .border(Color.black)
 .frame(width: 300, height: 300, alignment: .center)
 .onTapGesture {
 withAnimation(.linear(duration: 3)){
 numofCols = 4
 numofRows = 4
 }
 }
 }
 }
 */

/* SpiralGraph (TODO)
 
 struct SpiralGraph: Shape{
 var innerRadius: Int
 var outerRadius: Int
 var distance: Int
 let amount: CGFloat
 
 func path(in rect: CGRect) -> Path {
 return Path()
 }
 }
 
 func gcd(_ a: Int, _ b: Int) -> Int {
 var a = a
 var b = b
 
 while b != 0 {
 let temp = b
 b = a % b
 a = temp
 }
 
 return a
 }
 
 struct ContentView: View{
 var body: some View{
 Text("some text")
 }
 }
 */

/* Arrow
 
 struct Arrow: Shape {
 
 func path(in rect: CGRect) -> Path {
 var path = Path()
 
 path.move(to: CGPoint(x: 0, y: rect.midY))
 path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
 path.addLine(to: CGPoint(x: rect.midX, y: 0))
 path.addLine(to: CGPoint(x: 0, y:rect.midY))
 
 path.move(to: CGPoint(x: rect.maxX / 3, y: rect.midY))
 path.addLine(to: CGPoint(x: rect.maxX / 3, y: rect.maxY))
 path.addLine(to: CGPoint(x:rect.maxX*2/3, y:rect.maxY))
 path.addLine(to: CGPoint(x: rect.maxX*2/3, y: rect.midY))
 
 return path
 }
 }
 
 struct ContentView: View {
 @State var borderThickness: CGFloat = 10
 var body: some View{
 
 VStack{
 Arrow()
 .stroke(style: StrokeStyle(lineWidth: borderThickness, lineCap: .round, lineJoin: .round))
 .frame(width: 300, height: 400)
 .onTapGesture {
 withAnimation{
 borderThickness = CGFloat.random(in: 1...100)
 }
 }
 
 Slider(value: $borderThickness, in: 1...100)
 
 }
 }
 }
*/

/* Color Circling Rectangle
 */

struct ColorCirclingRentangle:View {
    var steps = 100
    var amount = 0.25 // The colorshift amount (from 0 to 1)
    
    
        
    var body: some View{
        ZStack{
            ForEach(0..<steps){ value in
                Rectangle()
                    .inset(by: CGFloat(value))
                    .strokeBorder(LinearGradient(gradient: Gradient(colors: [color(for: value, brightness: 0.5), color(for: value, brightness: 1)]), startPoint: .top, endPoint: .bottom))
                
            }
            
        }
    }
    
    func color(for value: Int, brightness: Double) -> Color {
        var hue = Double(value)/Double(self.steps) + self.amount
        if hue > 1 {
            hue -= 1
        }
        return Color(hue: hue, saturation: 1, brightness: brightness)
    }
}

struct ContentView: View {
    @State var steps:Int = 100
    @State var amount:CGFloat = 0
    var body: some View{
        VStack{
            ColorCirclingRentangle(steps: steps, amount: Double(amount))
                .frame(width: 200, height: 200, alignment: .center)
            
            Stepper("\(steps)",value:$steps, in: 1...100, step:5)
            Slider(value: $amount, in: 0...1)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

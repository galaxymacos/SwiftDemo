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


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

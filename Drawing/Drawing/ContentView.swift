//
//  ContentView.swift
//  Drawing
//
//  Created by Xun Ruan on 2021/7/9.
//

import SwiftUI

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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

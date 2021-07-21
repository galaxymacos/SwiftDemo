//
//  ContentView.swift
//  Timer
//
//  Created by Xun Ruan on 2021/7/21.
//

import SwiftUI

/* Timer
 struct ContentView: View {
 let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
 
 var body: some View {
 Text("Hello, world!")
 .onReceive(timer, perform: { time in
 print("The time is now \(time)")
 })
 
 
 }
 }
 */

/* Timer cancel
 struct ContentView: View {
 let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
 @State var counter = 0
 var body: some View{
 Text("Hello, World!")
 .onReceive(timer) { time in
 if self.counter == 5 {
 self.timer.upstream.connect().cancel()
 } else {
 print("The time is now \(time)")
 }
 
 self.counter += 1
 }
 }
 }
 */


/* Tiem tolerance
 */
struct ContentView: View{
    let timer = Timer.publish(every: 1,tolerance: 0.5, on: .main, in: .common)
    
    var body: some View{
        Text("Place holder")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

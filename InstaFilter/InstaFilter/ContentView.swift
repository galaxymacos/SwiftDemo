//
//  ContentView.swift
//  InstaFilter
//
//  Created by Xun Ruan on 2021/7/14.
//

import SwiftUI

/* Custom binding
 struct ContentView: View{
 // the struct never changes, so we can't attach property observers in it
 @State var blurAmount: CGFloat = 0{
 didSet{
 print("The new value is \(blurAmount)")
 }
 }
 
 var body: some View {
 let blur = Binding<CGFloat>(
 get: {
 self.blurAmount
 },
 set: {
 print("The new value is \(blurAmount)")
 self.blurAmount = $0
 }
 )
 
 VStack{
 Text("Hello, world!")
 .blur(radius: blurAmount)
 // UI doesn't update according to the variable blur, so we don't need to say "$blur"
 Slider(value: blur, in: 0...20)
 }
 
 }
 }
 */

struct ContentView: View {
    @State var showingActionSheet = false
    @State var backgroundColor = Color.gray
    
    
    var body: some View{
        Text("Hello world")
            .background(backgroundColor)
            .frame(width: 300, height: 300)
            .onTapGesture {
                showingActionSheet.toggle()
            }
            .actionSheet(isPresented: $showingActionSheet){
                ActionSheet(title: Text("Change background"), message: Text("Select a new color"), buttons: [
                    .default(Text("red")){self.backgroundColor = .red},
                    .default(Text("yellow")){self.backgroundColor = .yellow},
                    .default(Text("green")){self.backgroundColor = .green},
                    .cancel()
                ])
            }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

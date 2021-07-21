//
//  ContentView.swift
//  TapGesture
//
//  Created by Xun Ruan on 2021/7/20.
//

import SwiftUI

/* Tap gesture
 struct ContentView: View {
 var body: some View {
 
 VStack{
 Text("Double tap")
 .onTapGesture(count: 2) {
 print("Tap twice")
 }
 
 Text("Long pressed")
 //                .onLongPressGesture {
 //                    print("Long pressed")
 //                }
 .onLongPressGesture(minimumDuration: 2) {
 print("Long pressed for 2 seconds")
 }
 Text("Long pressed with closure")
 .onLongPressGesture(minimumDuration: 2, pressing: {progress in
 print("Progress is \(progress)")
 }){
 print("long pressed")
 }
 
 }
 }
 }
 */

/* scaling and rotating gesture
 struct ContentView: View{
 @State var currentAmount:CGFloat = 0.0
 @State var finalAmount:CGFloat = 1.0
 
 @State var currentRotationAmount: Angle = .degrees(0)
 @State var finalRotationAmount: Angle = .degrees(0)
 var body: some View{
 VStack{
 
 Text("scalable text")
 .scaleEffect(finalAmount+currentAmount)
 .gesture(
 MagnificationGesture()
 .onChanged{ amount in
 currentAmount = amount - 1
 }
 .onEnded{ amount in
 finalAmount += currentAmount
 currentAmount = 0
 }
 )
 
 Text("Rotable text")
 .rotationEffect(currentRotationAmount + finalRotationAmount)
 .gesture(
 RotationGesture()
 .onChanged{ angle in
 self.currentRotationAmount = angle
 }
 .onEnded{angle in
 self.finalRotationAmount += self.currentRotationAmount
 self.currentRotationAmount = .degrees(0)
 }
 )
 }
 }
 }
 */

/* Tap gesture priority
 struct ContentView: View {
 var body: some View{
 VStack{
 
 VStack{
 Text("text")
 // Second
 .onTapGesture {
 print("child")
 }
 }
 // Third
 .onTapGesture {
 print("parent")
 }
 // First
 .highPriorityGesture(
 TapGesture()
 .onEnded{
 print("high priority")
 }
 
 )
 
 // Simutaneous activated
 VStack{
 Text("child and parent")
 .onTapGesture {
 print("child")
 }
 }
 
 .simultaneousGesture(
 TapGesture()
 .onEnded{
 print("parent")
 })
 }
 }
 }
 */

struct ContentView: View {
    @State var offset: CGSize = CGSize.zero
    @State var isDragging = false
    var body: some View{
        
        let draggingGesture = DragGesture()
            .onChanged{ value in
                offset = value.translation
            }
            .onEnded{ _ in
                withAnimation{
                    offset = CGSize.zero
                    isDragging = false
                }
            }
        
        let longPressedGesture = LongPressGesture()
            .onEnded{value in
                withAnimation{
                    isDragging = true
                }
            }
        
        let combinedGesture = longPressedGesture.sequenced(before: draggingGesture)
        
        return Circle()
            .fill(Color.red)
            .frame(width: 64, height: 64)
            .scaleEffect(isDragging ? 1.5 : 1)
            .offset(offset)
            .gesture(combinedGesture)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

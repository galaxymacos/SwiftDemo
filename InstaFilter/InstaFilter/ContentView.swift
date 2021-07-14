//
//  ContentView.swift
//  InstaFilter
//
//  Created by Xun Ruan on 2021/7/14.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

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

/* ActionSheet
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
 */

struct ContentView: View {
    @State var image: Image?
    var body: some View{
        VStack{
            image?
                .resizable()
                .scaledToFit()
        }
        .onAppear(perform: loadImage)
    }
    
    func loadImage(){
        guard let inputImage = UIImage(named: "Example") else {return}
        let beginImage = CIImage(image: inputImage)
        
        let context = CIContext()
        
//        let currentFilter = CIFilter.sepiaTone()
//        currentFilter.inputImage = beginImage
//        currentFilter.intensity = 1
        
//        let currentFilter = CIFilter.pixellate()
//        currentFilter.inputImage = beginImage
//        currentFilter.scale = 40

//        let currentFilter = CIFilter.crystallize()
//        currentFilter.inputImage = beginImage
//        currentFilter.radius = 40
        
        // filter is working on CIImage
        guard let currentFilter = CIFilter(name: "CITwirlDistortion") else { return }
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        currentFilter.setValue(500, forKey: kCIInputRadiusKey)
        currentFilter.setValue(CIVector(x: inputImage.size.width / 2, y: inputImage.size.height / 2), forKey: kCIInputCenterKey)

        
        // From CIImage to CGImage
        guard let outputImage = currentFilter.outputImage else {return}
        if let cgImg = context.createCGImage(outputImage, from: outputImage.extent){
            let uiImg = UIImage(cgImage: cgImg)
            image = Image(uiImage: uiImg)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

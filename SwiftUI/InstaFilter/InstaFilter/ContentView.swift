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
    @State var inputImage: UIImage?
    @State var image: Image?
    @State var showImagePicker = false
    
    @State var intensity = 0.5
    var body: some View{
        NavigationView{
            VStack{
                
                ZStack{
                    Rectangle()
                        .fill(Color.secondary)
                    if let image = image{
                        image
                            .resizable()
                            .scaledToFit()
                    }
                    else{
                        Text("Tap to select an image")
                            .foregroundColor(.white)
                            .font(.headline)
                            .onTapGesture {
                                showImagePicker = true
                            }
                    }
                }
                
                HStack{
                    Slider(value: $intensity, in: 0...1)
                }
                
                HStack{
                    Button("Change filter"){
                        // Change filter
                        
                    }
                    Spacer()
                    Button("Add"){
                        showImagePicker = true
                    }
                }
            }
            .sheet(isPresented: $showImagePicker, onDismiss: loadImage){
                ImagePicker(image: $inputImage)
            }
            .navigationBarTitle("InstaFilter")
            
        }
    }
    
    func loadImage(){
        guard let inputImage = inputImage else { return }
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
        currentFilter.setValue(1000, forKey: kCIInputRadiusKey)
        currentFilter.setValue(CIVector(x: inputImage.size.width / 2, y: inputImage.size.height / 2), forKey: kCIInputCenterKey)
        
        
        // From CIImage to CGImage
        guard let outputImage = currentFilter.outputImage else {return}
        if let cgImg = context.createCGImage(outputImage, from: outputImage.extent){
            let uiImg = UIImage(cgImage: cgImg)
            image = Image(uiImage: uiImg)
        }
        
        
//        UIImageWriteToSavedPhotosAlbum(inputImage, nil, nil, nil)
        let imageSaver = ImageSaver()
        imageSaver.writeToPhotoAlbum(image: inputImage)
    }
}

class ImageSaver: NSObject {
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
    }

    @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        print("Save finished!")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

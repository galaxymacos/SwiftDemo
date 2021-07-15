//
//  ContentView.swift
//  InstaFilterApp
//
//  Created by Xun Ruan on 2021/7/15.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    @State var image: Image?
    @State var filterIntensity:Double = 0.5
    @State private var showingImagePicker = false
    @State var inputImage: UIImage?
    @State private var currentFilter = CIFilter.sepiaTone()
    
    // context is expensive to create, so keep it forever as possible
    let context = CIContext()
    var body: some View {
        let intensity = Binding<Double>(
            get: {
                filterIntensity
            },
            set: {
                filterIntensity = $0
                applyProcessing()
            }
        )
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
                        Text("Tap to add a photo")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                }
                .onTapGesture {
                    showingImagePicker = true
                }
                HStack{
                    Text("Intensity")
                    Slider(value: intensity, in: 0.0...1.0)
                }
                .padding([.horizontal, .top])
                HStack{
                    Button("Change filter"){
                        //TODO change the filter
                    }
                    Spacer()
                    Button("Save"){
                        //TODO save the image
                    }
                }
            }
            .padding([.horizontal, .bottom])
            .navigationBarTitle("Instafilter")
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage){
                ImagePicker(image: self.$inputImage)
            }
        }
    }
    
    func loadImage(){
        guard let inputImage = inputImage else{return}
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    
    func applyProcessing(){
        currentFilter.intensity = Float(filterIntensity)
        guard let outputImage = currentFilter.outputImage else {return}
        
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent){
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

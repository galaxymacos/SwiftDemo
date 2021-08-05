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
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    private let sepiaToneFilter = CIFilter.sepiaTone()
    private let crystalizeFilter = CIFilter.crystallize()
    private let gaussianBlurFilter = CIFilter.gaussianBlur()
    private let pixellateFilter = CIFilter.pixellate()
    private let edgesFilter = CIFilter.edges()
    private let unsharpMaskFilter = CIFilter.unsharpMask()
    private let vignetteFilter = CIFilter.vignette()
    @State private var showingFilterSheet = false
    @State var processedImage: UIImage?
    @State var showingNoPhotoAddedAlert = false
    
    @State var slider1Name = "Intensity"
    @State var slider2Name = "Radius"
    @State var slider3Name = "Scale"
    @State var intensityValue: Double = 0
    @State var radiusValue: Double = 0
    @State var scaleValue:Double = 0
    var CIFilterNamedict:[CIFilter:String]{
        [
            sepiaToneFilter: "Sepia Tone",
            crystalizeFilter: "Crystallize",
            gaussianBlurFilter: "Gaussian Blur",
            pixellateFilter: "Pixellate",
            edgesFilter: "Edges",
            unsharpMaskFilter: "Unsharp Mask",
            vignetteFilter: "Vignette"
        ]
    }
    @State var filterButtonText: String = "No filter"
    
    // context is expensive to create, so keep it forever as possible
    let context = CIContext()
    var body: some View {
        
        let intensity = Binding<Double>(
            get: {
                intensityValue
            },
            set: {
                intensityValue = $0
                applyProcessing()
            }
        )
        let radius = Binding<Double>(
            get: {
                radiusValue
            },
            set: {
                radiusValue = $0
                applyProcessing()
            }
        )
        let scale = Binding<Double>(
            get: {
                scaleValue
            },
            set: {
                scaleValue = $0
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
                if currentFilter.inputKeys.contains(kCIInputIntensityKey){
                    HStack{
                        Text("Intensity")
                        Slider(value: intensity, in: 0.0...1.0)
                    }
                    .padding([.horizontal, .top])
                    
                }
            
                if currentFilter.inputKeys.contains(kCIInputRadiusKey){
                    HStack{
                        Text("Radius")
                        Slider(value: radius, in: 0.0...1.0)
                    }
                    .padding([.horizontal, .top])
                }
                
                if currentFilter.inputKeys.contains(kCIInputScaleKey){
                    HStack{
                        Text("Scale")
                        Slider(value: scale, in: 0.0...1.0)
                    }
                    .padding([.horizontal, .top])
                }
                
                HStack{
                    Button(filterButtonText){
                        showingFilterSheet = true
                    }
                    Spacer()
                    Button("Save"){
                        guard let processedImage = processedImage else {
                            showingNoPhotoAddedAlert = true
                            return
                        }
                        let imageSaver = ImageSaver()
                        imageSaver.successHandler = {
                            print("Success")
                        }
                        imageSaver.failureHandler = {
                            print("\($0.localizedDescription)")
                        }
                        imageSaver.writeToPhotoAlbum(image: processedImage)
                    }
                    .alert(isPresented: $showingNoPhotoAddedAlert, content: {
                        Alert(title:Text("Error"), message: Text("No photo added yet"), dismissButton: .default(Text("Ok")))
                    })
                }
            }
            .padding([.horizontal, .bottom])
            .navigationBarTitle("Instafilter")
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage){
                ImagePicker(image: self.$inputImage)
            }
            .actionSheet(isPresented: $showingFilterSheet){
                ActionSheet(title: Text("Filter"), message: Text("Choose your filter"), buttons:
                                [
                                    .default(Text("Crystallize")){self.setFilter(crystalizeFilter)},
                                    .default(Text("Edges")) { self.setFilter(edgesFilter) },
                                    .default(Text("Gaussian Blur")) { self.setFilter(gaussianBlurFilter) },
                                    .default(Text("Pixellate")) { self.setFilter(pixellateFilter) },
                                    .default(Text("Sepia Tone")) { self.setFilter(sepiaToneFilter) },
                                    .default(Text("Unsharp Mask")) { self.setFilter(unsharpMaskFilter) },
                                    .default(Text("Vignette")) { self.setFilter(vignetteFilter) },
                                    .cancel()
                                ])
                
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
        // This way of setting intensity only works in certain filter
//        currentFilter.intensity = Float(filterIntensity)
        print("apply processing")
        let inputKeys = currentFilter.inputKeys
        if inputKeys.contains(kCIInputIntensityKey) {currentFilter.setValue(intensityValue, forKey: kCIInputIntensityKey)}
        if inputKeys.contains(kCIInputRadiusKey) {currentFilter.setValue(radiusValue * 200, forKey: kCIInputRadiusKey)}
        if inputKeys.contains(kCIInputScaleKey) {currentFilter.setValue(scaleValue * 10, forKey: kCIInputScaleKey)}
        guard let outputImage = currentFilter.outputImage else {return}
        
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent){
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
            processedImage = uiImage
        }
    }
    
    func setFilter(_ filter: CIFilter){
        currentFilter = filter
        filterButtonText = CIFilterNamedict[currentFilter] ?? "?"
        loadImage()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

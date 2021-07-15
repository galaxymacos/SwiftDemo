//
//  ContentView.swift
//  InstaFilterApp
//
//  Created by Xun Ruan on 2021/7/15.
//

import SwiftUI

struct ContentView: View {
    @State var image: Image?
    @State var intensity = 0.5
    @State private var showingImagePicker = false
    @State var inputImage: UIImage?
    var body: some View {
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
                    Slider(value: $intensity, in: 0.0...1.0)
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
        image = Image(uiImage: inputImage)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

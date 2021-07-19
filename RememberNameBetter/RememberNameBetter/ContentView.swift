//
//  ContentView.swift
//  RememberNameBetter
//
//  Created by Xun Ruan on 2021/7/18.
//

import SwiftUI

struct ContentView: View {
    @State private var image: Image?
    @State private var inputImage: UIImage?
    @State var showingImagePickerView = false
    @State var showingEditView = false
    
    var personImageDict = [Person: Image]()
    
    var body: some View {
        NavigationView{
            VStack{
                image?
                    .resizable()
                    .scaledToFit()
                    
            }
            .navigationBarItems(trailing: Button(action: {showingImagePickerView = true}){
                Image(systemName: "plus")
            })
        }
        .sheet(isPresented: $showingImagePickerView,onDismiss: loadImage, content: {
            ImagePicker(image: $inputImage)
        })
    }
    
    func loadImage() {
        if let inputImage = inputImage{
            image = Image(uiImage: inputImage)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

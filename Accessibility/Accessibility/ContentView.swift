//
//  ContentView.swift
//  Accessibility
//
//  Created by Xun Ruan on 2021/7/18.
//

import SwiftUI

struct ContentView: View {
    let pictures = [
            "ales-krivec-15949",
            "galina-n-189483",
            "kevin-horstmann-141705",
            "nicolas-tissot-335096"
        ]
    
    let labels = [
        "Tulips",
        "Frozen tree buds",
        "Sunflowers",
        "Fireworks",
    ]
    
    @State var sliderValue:Double = 5
    
    @State var randomPictureIndex = Int.random(in: 0...3)
    var body: some View {
        VStack{
            Image(pictures[randomPictureIndex])
                .resizable()
                .scaledToFit()
                .onTapGesture {
                    randomPictureIndex = Int.random(in: 0...3)
                }
                .accessibility(label: Text(labels[randomPictureIndex]))
                .accessibility(addTraits: .isButton)
                .accessibility(removeTraits: .isImage)
            
            // read as: "image"
            Image(decorative: "nicolas_tissot-335096")
            
            // read as nothing
            Text("slience text")
                .accessibility(hidden: true)
                
            Slider(value: $sliderValue, in: 1.0...10.0)
                .accessibility(value: Text("\(Int(sliderValue))"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

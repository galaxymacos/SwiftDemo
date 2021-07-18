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
    
    @State var randomPictureIndex = Int.random(in: 0...3)
    var body: some View {
        Image(pictures[randomPictureIndex])
            .resizable()
            .scaledToFit()
            .onTapGesture {
                randomPictureIndex = Int.random(in: 0...3)
            }
            .accessibility(label: Text(labels[randomPictureIndex]))
            .accessibility(addTraits: .isButton)
            .accessibility(removeTraits: .isImage)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

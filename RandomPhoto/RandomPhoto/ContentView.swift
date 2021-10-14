//
//  ContentView.swift
//  RandomPhoto
//
//  Created by 阮迅 on 2021-10-14.
//

import SwiftUI

struct ContentView: View {
    
    @State var imageData: Data?
    @State var backgroundColor: Color?
    
    var body: some View {
        NavigationView {
            ZStack {
                backgroundColor ?? Color.yellow
                VStack {
                    Spacer()
                    if imageData != nil {
                        Image(uiImage: UIImage(data: imageData!)!)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                    }
                    else {
                        Image(systemName: "error")
                            .frame(width: 200, height: 200)
                            .background(Color.red)
                    }
                    Spacer()
                    Button {
                        // TODO: G R I
                        let urlString = "https://source.unsplash.com/random/600x600"
                        let url = URL(string: urlString)!
                        guard let data = try? Data(contentsOf: url) else { return }
                        imageData = data
                        let red = Double.random(in: 0...1)
                        let green = Double.random(in: 0...1)
                        let blue = Double.random(in: 0...1)
                        let newColor = Color(red: red, green: green, blue: blue)
                        backgroundColor = newColor
                    } label: {
                        Text("Generate random Photo")
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundColor(.white)
                    )
                    .padding(.bottom, 50)
                    
                }

            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

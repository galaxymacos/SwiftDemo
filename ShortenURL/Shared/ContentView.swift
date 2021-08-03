//
//  ContentView.swift
//  Shared
//
//  Created by Xun Ruan on 2021/8/2.
//

import SwiftUI

struct ContentView: View {
    @State var url = ""
    
    var body: some View {
        NavigationView{
            ScrollView(.vertical){
                header()
            }
            .navigationTitle(Text("Shorten URL"))
        }
    }
    
    // Create a part of view that shows header
    @ViewBuilder
    func header() -> some View{
        VStack{
            Text("Enter the url to be shortened")
                .bold()
                .font(.system(size: 24))
                .foregroundColor(Color.white)
            TextField("URL...", text: $url)
                .padding()  // This padding is added between the textfield and the background
                .background(Color.white)
                .cornerRadius(10)
                .padding()  // This padding is added between the background and the environment
            Button(action: {
                
            }, label: {
                Text("Submit")
                    .bold()
                    .foregroundColor(.white)
                    .frame(width: 240, height: 50)
                    .background(Color.pink)
                    .cornerRadius(20)
                    .padding()
            })
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
        .background(Color.blue)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

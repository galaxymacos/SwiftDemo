//
//  ContentView.swift
//  Shared
//
//  Created by Xun Ruan on 2021/8/2.
//

import SwiftUI

struct ContentView: View {
    @State var url = ""
    // @StateObject is used to link the view and view model
    @StateObject var viewModel = ViewModel()
    
    
    var body: some View {
        NavigationView{
            ScrollView(.vertical){
                header()
                
                ForEach(viewModel.models, id: \.self){ model in
                    HStack{
                        VStack(alignment: .leading){
                            Text("https://1pt.co/"+model.short)
                            Text(model.long)
                        }
                        Spacer()
                    }
                    .padding()
                    .onTapGesture {
                        guard let url = URL(string: "https://1pt.co/"+model.short) else{
                            return
                        }
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                }
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
                .autocapitalization(.none)
                .padding()  // This padding is added between the textfield and the background of the textfield
                .background(Color.white)
                .cornerRadius(10)
                .padding()  // This padding is added between the background of the textfield and the environment
            Button(action: {
                // make api call
                guard !url.isEmpty else{
                    return
                }
                viewModel.submit(urlString: url)
                url = ""
                
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
        // Detect the boundaries of the phone screen
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
        .background(Color.blue)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

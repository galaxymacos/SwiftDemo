//
//  ContentView.swift
//  ContentLoader
//
//  Created by Xun Ruan on 2021/8/3.
//

import SwiftUI

struct URLImage: View{
    @StateObject var urlImageViewModel = ViewModelUrlImage()
    var urlString = ""
    
    var body: some View{
        if let data = urlImageViewModel.data, let uiImage = UIImage(data: data){
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFill()
                .frame(width: 130, height: 70)
                
        }
        else{
            Image(systemName: "Video")
                .resizable()
                .scaledToFill()
                // The same as
//                .aspectRatio(contentMode: .fill)
                .frame(width: 130, height: 70)
                .background(Color.gray)
                .onAppear{
                    urlImageViewModel.fetchImageFromUrl(urlString: urlString)
                }
        }
    }
    
    
}

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    var body: some View {
        NavigationView{
            List{
                ForEach(viewModel.courses, id: \.self){course in
                    HStack{
                        URLImage(urlString: course.image)
                            .frame(width: 130, height: 70)
                            .background(Color.black)
                        Text(course.name)
                            .bold()
                    }
                    .padding(3)
                }
            }
            .navigationTitle("Courses")
            .onAppear{
                viewModel.fetch()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

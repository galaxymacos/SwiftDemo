//
//  ContentView.swift
//  ContentLoader
//
//  Created by Xun Ruan on 2021/8/3.
//

import SwiftUI

struct URLImage: View{
    var urlString = ""
    @State var data: Data?  // We want the view (In this case, the image) to update when we have data, that's why we mark it as @State
    var body: some View{
        if let data = data, let uiImage = UIImage(data: data){
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
                .onAppear(perform: fetchImageFromUrl)
        }
    }
    
    private func fetchImageFromUrl(){
        guard let url = URL(string: urlString) else{
            return
        }
        let task = URLSession.shared.dataTask(with: url){data, _, _ in
            self.data = data    //Function can't assign to the variable in struct that doesn't mark as @State
        }
        task.resume()
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

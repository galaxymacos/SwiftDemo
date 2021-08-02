//
//  ContentView.swift
//  NetworkRequest
//
//  Created by Xun Ruan on 2021/8/1.
//

import SwiftUI

// Model
// Write this struct according to the JSON file
struct Photo: Codable, Identifiable{
    let id: String
    let author: String
    let width, height: Int
    let url, download_url: URL
}

// ViewModel
final class Remote<A>: ObservableObject{
    @Published var result: Result<A,Error>? = nil
    var value: A? { try？result?.get() }
    let url: URL
    let transform: (Data)->A?
    
    init(url: URL, transform: @escaping (Data) -> A?){
        self.url = url
        self.transform = transform
    }
}

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

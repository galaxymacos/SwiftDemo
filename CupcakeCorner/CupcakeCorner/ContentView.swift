//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Xun Ruan on 2021/7/11.
//

import SwiftUI


class User: ObservableObject, Codable {
    // @Published makes Published struct, which does not conform to Codable
    @Published var name = "Paul Hudson"
    
    // Telling swift which properites should eb loaded and unloaded
    
    //  every case in our enum is the name of a property we want to load and save
    enum CodingKeys: CodingKey {
        case name
    }
    
    // Th
    required init(from decoder: Decoder) throws{
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
    }
}

struct ContentView: View {
    
    var body: some View {
        Text("Some text")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  ContentView.swift
//  SystemImageColorChanger
//
//  Created by Xun Ruan on 2021/7/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Image(systemName: "xmark.circle")
            .foregroundColor(Color(red: 1, green: 0, blue: 0))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

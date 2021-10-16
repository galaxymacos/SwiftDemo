//
//  ContentView.swift
//  CustomTabBar
//
//  Created by 阮迅 on 2021-10-15.
//

import SwiftUI

struct ContentView: View {
    @State var selectedIndex = 0
    let icons = ["person", "gear", "plus.app.fill", "pencil", "lasso"]
    var body: some View {
        VStack {
            ZStack {
                switch selectedIndex {
                case 0:
                    Text("First View")
                default:
                    Text("Other views")
                }
            }
            Spacer()
            HStack(spacing: 30) {
                ForEach(0..<5) { num in
                    Button {
                        selectedIndex = num
                    } label: {
                        Image(systemName: icons[num])
                            .font(.system(size: 30))
                            .foregroundColor(num == selectedIndex ? .black : Color(white: 0.8))
                    }

                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  ContentView.swift
//  CustomTabBar
//
//  Created by 阮迅 on 2021-10-15.
//

import SwiftUI

struct ContentView: View {
    @State var selectedIndex = 0
    let tabBarImageNames = ["person", "gear", "plus.app.fill", "pencil", "lasso"]
    @State var showFullscreenModal = false
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                
                Spacer()
                    .fullScreenCover(isPresented: $showFullscreenModal, onDismiss: nil) {
                        Text("Fullscreen modal")
                    }
                
                switch selectedIndex {
                case 0:
                    NavigationView {
                        ScrollView(showsIndicators: false) {
                            VStack(alignment: .leading, spacing: 10) {
                                ForEach(0..<100) { num in
                                    HStack {
                                        Text("Task \(num)")
                                            .padding([.leading])
                                        Spacer()
                                    }.frame(maxWidth: .infinity)
                                    Divider()
                                }
                            }
                        }
                        .navigationTitle("First Tab")
                    }
                default:
                    NavigationView {
                        Text("Other views")
                    }
                }
            }
//            Spacer()    // MARK: Spacer has a minimum height
            Divider()
            HStack {
                ForEach(0..<5) { num in
                    Button {
                        selectedIndex = num
                    } label: {
                        Spacer()
                        if num == 2 {
                            Image(systemName: tabBarImageNames[num])
                                .font(.system(size: 32))
                                .foregroundColor(.red)
                        }
                        else {
                            Image(systemName: tabBarImageNames[num])
                                .font(.system(size: 24))
                                .foregroundColor(num == selectedIndex ? .black : Color(white: 0.8))
                        }
                        Spacer()
                    }
                    .padding(.top, 10)
                    
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

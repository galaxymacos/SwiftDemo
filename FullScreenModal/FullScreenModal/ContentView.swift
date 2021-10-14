//
//  ContentView.swift
//  FullScreenModal
//
//  Created by 阮迅 on 2021-10-14.
//

import SwiftUI

struct ContentView: View {
    @State var isPresented = false
    var body: some View {
        ZStack {
            NavigationView {
                VStack {
                    Button {
                        withAnimation {
                            isPresented.toggle()
                            
                        }
                    } label: {
                        Text("Show modal")
                    }
                }
                .navigationTitle("Show Modal")
            }
            
            
            ZStack {
                Color.blue
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    HStack {
                        Text("Dismiss")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.leading)
                        Spacer()
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.white)
                            .padding(.trailing)
                            .onTapGesture {
                                withAnimation {
                                    isPresented.toggle()
                                }
                            }
                    }
                    Spacer()
                }
                
            }
//            .offset(x: 0, y: isPresented ? 0 : 800)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

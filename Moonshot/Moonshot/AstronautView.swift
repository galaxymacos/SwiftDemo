//
//  AstronautView.swift
//  Moonshot
//
//  Created by Xun Ruan on 2021/7/9.
//

import SwiftUI

struct AstronautView: View {
    var astronaut: Astronaut
    var body: some View {
        NavigationView{
            // GrometryReader/ScrollView/VStack combination
            
            GeometryReader{ geometry in
                ScrollView(.vertical){
                    VStack{
                        Image("\(self.astronaut.id)")
                            .resizable()
                            .scaledToFit()
                            .frame(width: geometry.size.width)
                        
                        Text(astronaut.description)
                            .padding()
                    }
                }
                
            }
            .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
        }
    }
}

struct AstronautView_Previews: PreviewProvider {
    // be careful of the static
    static var astronauts:[Astronaut] = Bundle.main.decode("astronauts.json")
    static var previews: some View {
        AstronautView(astronaut: astronauts[0])
    }
}

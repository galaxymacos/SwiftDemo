//
//  AstronautView.swift
//  Moonshot
//
//  Created by Xun Ruan on 2021/7/9.
//

import SwiftUI

struct AstronautView: View {
    var astronaut: Astronaut
    var missions: [Mission] = Bundle.main.decode("missions.json")
    var missionsSpecified: [Mission]{
        var matches = [Mission]()
        for mission in missions{
            if mission.crew.first(where: {$0.name == self.astronaut.id}) != nil{
                matches.append(mission)
            }
        }
//        return missions
        return matches
    }
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
                        
                        Text("Mission:")
                            .font(.headline)
                        
//                        ForEach(missions, id: \.id){mission in
//                            Text(mission.displayedName)
//                        }
                        Text(missionsSpecified[0].displayedName)
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
    static var missions:[Mission] = Bundle.main.decode("missions.json")
    static var previews: some View {
        AstronautView(astronaut: astronauts[3], missions: missions)
    }
}

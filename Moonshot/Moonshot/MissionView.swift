//
//  MissionView.swift
//  Moonshot
//
//  Created by Xun Ruan on 2021/7/9.
//

import SwiftUI

struct MissionView: View {
    
    struct CrewMember {
        var role:String
        var astronaut: Astronaut
    }
    
    // All the astronauts on this mission
    var astronauts: [CrewMember]
    
    init(mission: Mission, astronauts: [Astronaut]){
        self.mission = mission
        var matchs = [CrewMember]()
        
        for crewMember in mission.crew{
            if let match = try? astronauts.first(where: {$0.id == crewMember.name}) {
                matchs.append(CrewMember(role: crewMember.role, astronaut: match))
            }
            else{
                fatalError("Cannot find crew member")
            }
        }
        self.astronauts = matchs
    }
    
    let mission: Mission
    var body: some View {
        NavigationView{
            GeometryReader{geometry in
                ScrollView(.vertical){
                    VStack{
                        Image(mission.imageS)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: geometry.size.width*0.75)
                        
                        Text(mission.description)
                            .padding()
                        
                        ForEach(astronauts, id: \.role){ member in
                            HStack{
                                Image(member.astronaut.id)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 80, height: 63)
                                    .clipShape(Capsule())
                                    .overlay(Capsule().stroke(Color.primary, lineWidth: 1))
                                VStack(alignment: .leading){
                                    Text("\(member.astronaut.name)")
                                        .font(.headline)
                                    Text("\(member.role)")
                                        .foregroundColor(.secondary)                                  
                                }
                            }
                            .padding()
                            
                            
                        }
                        Spacer(minLength: 25)
                        
                        
                    }
                    
                }
                
            }
            .navigationBarTitle(Text(mission.displayedName), displayMode: .inline)
            
        }
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions:[Mission] = Bundle.main.decode("missions.json")
    static let astronauts:[Astronaut] = Bundle.main.decode("astronauts.json")
    static var previews: some View {
        MissionView(mission: missions[1], astronauts: astronauts)
    }
}

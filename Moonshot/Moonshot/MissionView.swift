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
            GeometryReader{fullView in
                ScrollView(.vertical){
                    VStack{
                                
                            //                            .scaleEffect(geometry.size.width)

                        GeometryReader{geo in
                            Image(mission.imageS)
                                .resizable()
                                .scaledToFit()
                                .scaleEffect(geo.frame(in: .global).midY / fullView.size.height + 0.6 < 0.8 ? 0.8 : geo.frame(in: .global).midY / fullView.size.height + 0.6)
                        }
                        .frame(height: 300)
//                        .background(Color.green)
                        
//                                .frame(width: fullView.size.width*0.75)

                        
                        Text(mission.formattedLaunchDate)
                        
                        Text(mission.description)
                            .padding()
                            // It will not be shrinked. layoutPriority(0) will get shrinked. (If there is not enough space)
                            .layoutPriority(1)

                        
                        
                        
                        ForEach(astronauts, id: \.role){ member in
                            NavigationLink(destination: AstronautView(astronaut: member.astronaut)){
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
                            // else the text in NavigationLink will be colored blue indicating that it is a "hyperlink"
                            .buttonStyle(PlainButtonStyle())
                            
                            
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

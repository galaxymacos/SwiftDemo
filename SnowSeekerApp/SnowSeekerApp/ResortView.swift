//
//  ResortView.swift
//  SnowSeekerApp
//
//  Created by Xun Ruan on 2021/7/27.
//

import SwiftUI


extension String: Identifiable {
    public var id: String {
        self
    }
}

struct ResortView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    // We can get this environmentObject because ResortView is a child of ContentView
    @EnvironmentObject var favorites: Favorites
    let resort: Resort
    
    @State private var selectedFacility: Facility?
    
    
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading, spacing: 0) {
                Image(decorative: resort.id)
                    .resizable()
                    .scaledToFit()
                
                HStack {
                    if(sizeClass == .compact){
                        Spacer()
                        VStack{ ResortDetailsView(resort: resort)}
                        VStack{ SkiDetailsView(resort: resort)}
                        Spacer()
                    }
                    else{
                        ResortDetailsView(resort: resort)
                        // tell Spacer() to only work in landscape mode and stop them from adding space vertically
                        // this spacer will have a fexible width, and will be pushed by its child view
                        Spacer().frame(height: 0)
                        SkiDetailsView(resort: resort)
                    }
                }
                .font(.headline)
                .foregroundColor(.secondary)
                .padding(.top)
                
                Group {
                    Text(resort.description)
                        .padding(.vertical)
                    
                    Text("Facilities")
                        .font(.headline)
                    
                    // Outdated (Old)
                    //                    Text(resort.facilities.joined(separator: ","))
                    
                    // A better (automatic) way to join strings together
                    Text(ListFormatter.localizedString(byJoining: resort.facilities)).padding(.vertical)
                    
                    HStack {
                        ForEach(resort.facilityTypes) { facility in
                            facility.icon
                                .font(.title)
                                .onTapGesture {
                                    selectedFacility = facility
                                }
                        }
                    }
                    .padding(.vertical)
                }
                .padding(.horizontal)
            }
            Button(favorites.contains(resort) ? "Remove from favorite" : "Add to favorite"){
                if favorites.contains(resort){
                    favorites.remove(resort)
                }
                else{
                    favorites.add(resort)
                }
            }
            .padding()
        }
        
        .alert(item: $selectedFacility) { facility in
            facility.alert
        }
        
        .navigationBarTitle(Text("\(resort.name), \(resort.country)"), displayMode: .inline)
    }
}

struct ResortView_Previews: PreviewProvider {
    static var previews: some View {
        ResortView(resort: Resort.example)
    }
}

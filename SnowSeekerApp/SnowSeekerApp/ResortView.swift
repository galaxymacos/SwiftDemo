//
//  ResortView.swift
//  SnowSeekerApp
//
//  Created by Xun Ruan on 2021/7/27.
//

import SwiftUI

struct ResortView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    let resort: Resort
    
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
                }
                .padding(.horizontal)
            }
        }
        .navigationBarTitle(Text("\(resort.name), \(resort.country)"), displayMode: .inline)
    }
}

struct ResortView_Previews: PreviewProvider {
    static var previews: some View {
        ResortView(resort: Resort.example)
    }
}

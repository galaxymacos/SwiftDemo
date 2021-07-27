//
//  ContentView.swift
//  SnowSeekerApp
//
//  Created by Xun Ruan on 2021/7/26.
//

import SwiftUI

struct ContentView: View {
    // add an example value in workflow so we can see change in the real time
    static let allResorts: [Resort] = Bundle.main.decode([Resort].self, for: "resorts.json")
    static let resort = allResorts[0]
    
    // when we use static let, swiftUI automatically makes it lazy, meaning that it won't be created unless we uses it
    static let randomResort = (Bundle.main.decode([Resort].self, for: "resorts.json") as [Resort])[0]
    
    let resorts: [Resort] = Bundle.main.decode([Resort].self, for: "resorts.json")
    
    var body: some View {
        NavigationView {
            // Every element in the list will be listed in an horizontal line
            List(resorts){ resort in
                // A NavigationLink on an element in the list will create a small arrow at the right, indicating the user that it can be tabbed
                NavigationLink(destination: ResortView(resort: resort)){
                    Image(resort.country)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 25)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.black, lineWidth: 1)
                        )
                    
                    VStack(alignment: .leading){
                        Text(resort.name)
                            .font(.headline)
                        Text("\(resort.runs) runs")
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationBarTitle(Text("Resorts"))
            
            // On landspace for iPhone XS max or iPad, the main window will be WelcomeView() and others will be hidden in a button
            WelcomeView()
        }
        .phoneOnlyStackNavigationView()
    }
}

// Stop phone from showing two views
extension View{
    func phoneOnlyStackNavigationView()-> some View{
        if UIDevice.current.userInterfaceIdiom == .phone{
            return AnyView(self.navigationViewStyle(StackNavigationViewStyle()))
        }
        else{
             return AnyView(self)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

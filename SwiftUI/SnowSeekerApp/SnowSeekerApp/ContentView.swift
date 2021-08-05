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

    @ObservedObject var favorites = Favorites()
    
    @State private var isShowingFilterActionSheet = false
    @State private var isShowingSortActionSheet = false
    

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
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
                    .layoutPriority(1)
                    if self.favorites.contains(resort){
                        Spacer()
                        Image(systemName: "heart.fill")
                            .accessibility(label: Text("This is a favorite resort"))
                            .foregroundColor(.red)
                    }
                }
                .actionSheet(isPresented: $isShowingFilterActionSheet){
                    ActionSheet(title: Text("Filter by"), message: nil, buttons: [
                        .default(Text("Country")){Resort.currentFilter = .country},
                        .default(Text("Size")){Resort.currentFilter = .size},
                        .default(Text("Price")){Resort.currentFilter = .price},
                        .default(Text("None")){Resort.currentFilter = .none}
                    ])
                }
            }
            .navigationBarItems(leading: Button("Filter"){self.isShowingFilterActionSheet = true},trailing: Button("Sort"){self.isShowingSortActionSheet = true})
            .navigationBarTitle(Text("Resorts"))
            .actionSheet(isPresented: $isShowingSortActionSheet){
                ActionSheet(title: Text("Sort by"), message: nil, buttons: [
                    .default(Text("alphabetical")){Resort.currentSorter = .alphabetical},
                    .default(Text("Country")){Resort.currentSorter = .country},
                    .default(Text("None")){Resort.currentSorter = .none}
                ])
            }
            
            // On landspace for iPhone XS max or iPad, the main window will be WelcomeView() and others will be hidden in a button
            WelcomeView()
        }
        .phoneOnlyStackNavigationView()
        // make its child view can modify this variable
        .environmentObject(favorites)
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

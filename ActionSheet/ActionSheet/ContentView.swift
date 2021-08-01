//
//  ContentView.swift
//  ActionSheet
//
//  Created by Xun Ruan on 2021/7/31.
//

import SwiftUI

struct ContentView: View {
    @State var showingFilterActionSheet = false
    @State var showingSortingActionSheet = false
    
    var body: some View {
        NavigationView{
            VStack{
                
            }
            .navigationBarItems(leading: Button("Sorting"){showingSortingActionSheet = true},trailing: Button("Filter"){showingFilterActionSheet = true})
            .actionSheet(isPresented: $showingFilterActionSheet, content: {
                ActionSheet(title: Text("Filters"), message: nil, buttons: [
                    .default(Text("By Country")){print("Filter by country")},
                    .default(Text("By size")){print("Filter by size")}
                ])
            })
        }
            
        .actionSheet(isPresented: $showingSortingActionSheet, content: {
            ActionSheet(title: Text("Sorters"), message: nil, buttons: [
                .default(Text("By size")){print("Sorting by size")},
                .default(Text("By people")){print("Sorting by people")}
            ])
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

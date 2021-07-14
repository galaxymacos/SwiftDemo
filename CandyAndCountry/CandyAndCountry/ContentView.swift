//
//  ContentView.swift
//  CandyAndCountry
//
//  Created by Xun Ruan on 2021/7/14.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Country.entity(), sortDescriptors: []) var countries: FetchedResults<Country>
    var body: some View{
        VStack{
            List{
                ForEach(countries, id: \.self){country in
                    Section(header: Text(country.wrappedFullName)){
                        ForEach(country.candyArray, id: \.self){candy in
                            Text(candy.wrappedName)
                        }
                    }
                }
                
            }
            Button("Add"){
                let kitkat = Candy(context: moc)
                kitkat.name = "KitKat"
                kitkat.origin = Country(context: moc)
                kitkat.origin?.fullName = "United Kingdom"
                kitkat.origin?.shortName = "UK"
                
                let mars = Candy(context: self.moc)
                mars.name = "Mars"
                mars.origin = Country(context: self.moc)
                mars.origin?.shortName = "UK"
                mars.origin?.fullName = "United Kingdom"
                
                let twix = Candy(context: self.moc)
                twix.name = "Twix"
                twix.origin = Country(context: self.moc)
                twix.origin?.shortName = "UK"
                twix.origin?.fullName = "United Kingdom"
                
                let toblerone = Candy(context: self.moc)
                toblerone.name = "Toblerone"
                toblerone.origin = Country(context: self.moc)
                toblerone.origin?.shortName = "CH"
                toblerone.origin?.fullName = "Switzerland"
                
                try? moc.save()
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

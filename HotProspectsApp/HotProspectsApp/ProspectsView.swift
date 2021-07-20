//
//  ProspectsView.swift
//  HotProspectsApp
//
//  Created by Xun Ruan on 2021/7/20.
//

import SwiftUI

enum FilterType{
    case none, contacted, uncontacted
}

struct ProspectsView: View {
    
    @EnvironmentObject var prospects: Prospects
    let filter: FilterType
    
    var title:String{
        switch filter {
        case .none:
            return "Everyone"
        case .contacted:
            return "Contacted"
        case .uncontacted:
            return "Uncontacted"
        }
    }
    
    var filteredProspects:[Prospect]{
        switch filter {
        case .none:
            return prospects.people
        case .contacted:
            return prospects.people.filter{$0.contacted}
        case .uncontacted:
            return prospects.people.filter{!$0.contacted}
        }
    }
    
    var body: some View {
        NavigationView{
            VStack{
                List{
                    ForEach(filteredProspects, id: \.id){person in
                        VStack(alignment: .leading){
                            Text(person.name)
                                .font(.headline)
                            Text(person.emailAddress)
                                .foregroundColor(.secondary)
                            
                        }
                    }
                }
                Text("People: \(prospects.people.count)")
                    .navigationBarTitle(title)
                    .navigationBarItems(trailing: Button(action: {
                        let prospect = Prospect()
                        prospect.name = "Paul Hudson"
                        prospect.emailAddress = "paul@hackingwithswift.com"
                        self.prospects.people.append(prospect)
                    }) {
                        Image(systemName: "qrcode.viewfinder")
                        Text("Scan")
                    })
            }
                
        }
    }
}

struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectsView(filter: .none)
            .environmentObject(Prospects())
    }
}

//
//  ProspectsView.swift
//  HotProspectsApp
//
//  Created by Xun Ruan on 2021/7/20.
//

import SwiftUI
import CodeScanner

enum FilterType{
    case none, contacted, uncontacted
}

struct ProspectsView: View {
    
    @EnvironmentObject var prospects: Prospects
    @State private var isShowingScanner = false
    
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
                        isShowingScanner = true
                    }) {
                        Image(systemName: "qrcode.viewfinder")
                        Text("Scan")
                    })
            }
                
        }
        .sheet(isPresented: $isShowingScanner){
            CodeScannerView(codeTypes: [.qr], simulatedData: "XunRuan\ngalaxymaxx@outlook.com", completion: self.handleScan)
        }
    }
    
    func handleScan(result: Result<String, CodeScannerView.ScanError>) {
        self.isShowingScanner = false
        
        switch result {
        case .success(let str):
            let components = str.components(separatedBy: "\n")
            guard components.count == 2 else {return}
            let prospect = Prospect()
            prospect.name = components[0]
            prospect.emailAddress = components[1]
            prospects.people.append(prospect)
        case .failure(_):
            print("Scanning failed")
        }
    }
}

struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectsView(filter: .none)
            .environmentObject(Prospects())
    }
}

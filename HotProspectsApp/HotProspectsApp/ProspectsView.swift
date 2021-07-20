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
            return prospects.people.filter{$0.isContacted}
        case .uncontacted:
            return prospects.people.filter{!$0.isContacted}
        }
    }
    
    var body: some View {
        NavigationView{
            VStack{
                List{
                    ForEach(filteredProspects, id: \.id){person in
                        HStack{
                            VStack(alignment: .leading){
                                Text(person.name)
                                    .font(.headline)
                                Text(person.emailAddress)
                                    .foregroundColor(.secondary)
                                
                            }
                            .contextMenu(menuItems: {
                                Button(person.isContacted ? "Mark UnContacted":"Mark Contacted"){
                                    prospects.toggle(person)
                                }
                                if !person.isContacted{
                                    Button("Remind me"){
                                        addNotification(person)
                                    }
                                    
                                }
                            })
                            Spacer()
                            if person.isContacted{
                                Image(systemName: "person.crop.circle.badge.checkmark")
                                    .padding([.trailing])
                            }
                            else{
                                Image(systemName: "person.crop.circle.badge.xmark")
                                    .padding([.trailing])
                            }
                        }
                    }
                    
                }
                Text("People: \(prospects.people.count)")
                    .navigationBarTitle(title)
                    .navigationBarItems(
                        trailing: Button(action: {
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
            prospects.add(prospect)
            // Save it to permanent storage
            
        case .failure(_):
            print("Scanning failed")
        }
    }
    
    func addNotification(_ prospect: Prospect){
        let center = UNUserNotificationCenter.current()
        
        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect)"
            content.subtitle = prospect.emailAddress
            var time = DateComponents()
            // It will trigger the next time when 9am come about
            time.hour = 9
//            let trigger = UNCalendarNotificationTrigger(dateMatching: time, repeats: false)
            let instantTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: instantTrigger)
            center.add(request)
            print("add request")
        }
        
        center.getNotificationSettings{settings in
            if(settings.authorizationStatus == .authorized){
                addRequest()
            }
            else{
                center.requestAuthorization(options: [.sound, .alert, .badge]){success, error in
                    if success {
                        addRequest()
                    }
                    else{
                        print("Request not permitted")
                    }
                }
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

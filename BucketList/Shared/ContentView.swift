//
//  ContentView.swift
//  Shared
//
//  Created by Xun Ruan on 2021/7/16.
//

import SwiftUI

struct User: Identifiable, Comparable {
    var id: UUID = UUID()
    var firstName: String
    var lastName: String
    
    static func < (user1: User, user2: User)->Bool{
        return user1.firstName < user2.firstName
    }
}

struct ContentView: View {
    let numbers = [1,5,3,6,2,9].sorted()
    
    // Thanks to the User struct being Comparable
    let users = [
        User(firstName: "Arnold", lastName: "Rimmer"),
        User(firstName: "Kristine", lastName: "Kochanski"),
        User(firstName: "David", lastName: "Lister"),
    ]
    // A better way
    .sorted()
    // This code is not reusable
//    .sorted{
//        $0.firstName<$1.firstName
//    }
    
    var body: some View {
        List(users, id: \.id){
            Text("\($0.firstName) \($0.lastName)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

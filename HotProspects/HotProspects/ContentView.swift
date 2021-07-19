//
//  ContentView.swift
//  HotProspects
//
//  Created by Xun Ruan on 2021/7/19.
//

import SwiftUI

/*  Environment object
 class User: ObservableObject {
 @Published var name: String = ""
 }
 
 struct EditView: View {
 @EnvironmentObject var user: User
 var body: some View{
 TextField("name", text: $user.name)
 }
 }
 
 struct DisplayView: View {
 @EnvironmentObject var user: User
 var body: some View{
 Text("Name is \(user.name)")
 }
 }
 
 struct ContentView: View {
 let user = User()
 
 var body: some View {
 VStack{
 Form{
 EditView()
 DisplayView()
 }
 }
 .environmentObject(user)
 }
 }
 */

/* TabView
 struct ContentView: View{
 @State var selectedTab = 0
 var body: some View{
 TabView(selection: $selectedTab) {
 Text("Tab 1")
 .onTapGesture {
 selectedTab = 1
 }
 .tabItem {
 Image(systemName: "star")
 Text("Tap 1")
 }
 .tag(0)
 
 Text("Tab 2")
 .onTapGesture {
 selectedTab = 0
 }
 .tabItem {
 Image(systemName: "star.fill")
 Text("Tap 2")
 }
 .tag(1)
 }
 }
 }
 */

/* Result Type*/

enum NetworkError:Error {
    case badURL, requestFailed, unknown
}

struct ContentView: View{
    var body: some View{
        Text("placeholder")
            .onAppear{
                fetchData(from: "www.apple.com"){ result in
                    switch result{
                    case .success(let str):
                        print("Info: \(str)")
                    case .failure(let error):
                        switch error {
                        case .badURL:
                            print("bad URL")
                        case .requestFailed:
                            print("request failed")
                        case .unknown:
                            print("unknown")
                            
                        }
                    default:
                        print("default")
                    }
                }
                
            }
    }
    
    // when we pass a closure to the function, swift wants to know whether we will use it immediately or use it later on
    func fetchData(from urlString: String, completion: @escaping (Result<String, NetworkError>)->Void) {
        guard let url = URL(string: urlString) else{
            completion(.failure(.badURL))
        }
        URLSession.shared.dataTask(with: url){data, response, error in
            DispatchQueue.main.async {
                if let data = data{
                    let stringData = String(decoding: data, as: UTF8.self)
                    completion(.success(stringData))
                }
                else if error != nil{
                    completion(.failure(.requestFailed))
                }
                else{
                    completion(.failure(.unknown))
                }
            }
        }
        .resume()
        
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

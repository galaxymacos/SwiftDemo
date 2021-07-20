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

/* Result Type
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
 }
 }
 
 }
 }
 
 // when we pass a closure to the function, swift wants to know whether we will use it immediately or use it later on
 func fetchData(from urlString: String, completion: @escaping (Result<String, NetworkError>)->Void) {
 guard let url = URL(string: urlString) else{
 return completion(.failure(.badURL))
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
 }
 */

/* Manually publishing ObservableObject changes
 struct ContentView: View {
 @ObservedObject var delayUpdater = DelayUpdater()
 var body: some View{
 Text("\(delayUpdater.value)")
 }
 }
 
 class DelayUpdater: ObservableObject{
 //    @Published var value = 0
 var value = 0{
 willSet{
 objectWillChange.send()
 }
 }
 
 init() {
 for i in 1...10 {
 DispatchQueue.main.asyncAfter(deadline: .now()+Double(i)){
 self.value += 1
 }
 }
 }
 }
 */

/* Controlling image intepolation in Swift
 struct ContentView: View {
 var body: some View{
 Image("example")
 // don't modify the edge
 .interpolation(.none)
 .resizable()
 .scaledToFit()
 .frame(maxHeight: .infinity)
 .background(Color.black)
 .edgesIgnoringSafeArea(.all)
 }
 }
 */

/* Creating context menus
 struct ContentView: View {
 @State private var backgroundColor = Color.red
 var body: some View{
 VStack{
 
 Text("placeholder")
 .background(backgroundColor)
 
 Text("Change color")
 .padding()
 .contextMenu{
 Button(action: {backgroundColor = .red}){
 Text("Red")
 if backgroundColor == .red{
 Image(systemName: "checkmark.circle.fill")
 }
 }
 Button(action: {backgroundColor = .green}){
 Text("Green")
 if backgroundColor == .green{
 Image(systemName: "checkmark.circle.fill")
 
 }
 }
 
 Button(action: {backgroundColor = .blue}){
 Text("Blue")
 if backgroundColor == .blue{
 Image(systemName: "checkmark.circle")
 }
 }
 }
 }
 
 }
 }
 */

struct ContentView: View {
    var body: some View{
        VStack{
            Button("Request Permission"){
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]){success, error in
                    if success{
                        print("success")
                    }
                    else if let error = error{
                        print(error.localizedDescription)
                    }
                }
            }
            Button("Schedule Notification"){
                // create notification content
                let content = UNMutableNotificationContent()
                content.title = "Fire"
                content.subtitle = "Address is Foshan Nanhai"
                content.sound = UNNotificationSound.default
                
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                
                UNUserNotificationCenter.current().add(request)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


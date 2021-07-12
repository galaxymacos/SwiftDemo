//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Xun Ruan on 2021/7/11.
//

import SwiftUI

/*  Adding codable conformance to @Published properties
 class User: ObservableObject, Codable {
 // @Published makes Published struct, which does not conform to Codable
 @Published var name = "Paul Hudson"
 
 // Telling swift which properites should eb loaded and unloaded
 
 //  every case in our enum is the name of a property we want to load and save
 enum CodingKeys: CodingKey {
 case name
 }
 
 // Th
 required init(from decoder: Decoder) throws{
 let container = try decoder.container(keyedBy: CodingKeys.self)
 name = try container.decode(String.self, forKey: .name)
 }
 
 func encode(to encoder: Encoder) throws {
 var container = encoder.container(keyedBy: CodingKeys.self)
 try container.encode(name, forKey: .name)
 }
 }
 
 struct ContentView: View {
 
 var body: some View {
 Text("Some text")
 }
 }
 */

/*  Sending and receiving Codable data using URLSession and swiftUI
 struct Response: Codable {
 var results: [Result]
 }
 
 struct Result: Codable {
 var trackId: Int
 var trackName: String
 var collectionName: String
 }
 
 struct ContentView: View {
 @State private var results = [Result]()
 
 var body: some View {
 List(results, id: \.trackId) { item in
 VStack(alignment: .leading) {
 Text(item.trackName)
 .font(.headline)
 Text(item.collectionName)
 }
 }
 .onAppear(perform: loadData)
 }
 
 func loadData(){
 // Create an url variable
 guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else{
 print("Can't find url")
 return
 }
 // Wrap the url into a request
 let request = URLRequest(url: url)
 
 // Create and start a networking task
 URLSession.shared.dataTask(with: request) { data, response, error in
 if let data = data{
 if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data){
 DispatchQueue.main.async {
 self.results = decodedResponse.results
 }
 }
 
 return
 }
 print("Fetch failed \(error?.localizedDescription ?? "Unknown error")")
 }.resume()
 }
 }
 */

/*  Use disabled(Bool) to make disable view from showing
 struct ContentView: View {
 @State var username: String = ""
 @State var email: String = ""
 
 var disabledForm: Bool{
 username.count<5 || email.count<5
 }
 
 var body: some View{
 Form{
 Section{
 TextField("Username", text:$username)
 TextField("email", text:$email)
 }
 Section{
 Button("Create account"){
 print("Create account")
 }
 }
 .disabled(disabledForm)
 }
 }
 }
 
 */

struct ContentView: View{
    @ObservedObject var order = Order()
    var body: some View{
        NavigationView{
            Form{
                Section{
                    Picker("Flavor", selection: $order.type){
                        ForEach(0..<Order.types.count){
                            Text("\(Order.types[$0])")
                        }
                    }
                    
                    Stepper(value: $order.quantity, in: 3...10){
                        Text("Quantity: \(order.quantity)")
                    }
                }
                
                Section{
                    Toggle(isOn: $order.specialRequestEnabled.animation(), label: {
                        Text("Any special order ?")
                    })
                    
                    if(order.specialRequestEnabled){
                        Toggle(isOn: $order.addSprinkles, label: {
                            Text("Add sprinkles ?")
                        })
                        Toggle(isOn: $order.extraTopping, label: {
                            Text("Extra topping ?")
                        })
                    }
                }
                
                Section{
                    NavigationLink(destination: AddressView(order: order)){
                        Text("Delivery detail")
                        
                    }
                }
            }
            .navigationBarTitle("Cupcake Corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

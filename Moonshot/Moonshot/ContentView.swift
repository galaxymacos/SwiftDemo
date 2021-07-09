//
//  ContentView.swift
//  Moonshot
//
//  Created by Xun Ruan on 2021-07-08.
//

import SwiftUI

/*  Resizing image to fit the screen using GrometryReader
struct ContentView: View {
    var body: some View {
        
        /* Not resizing image
         Image("Example")
         .frame(width: 300, height: 300)
         .clipped()
         
         */
        
        /*  Resize image combining .resizable() and .aspectRatio(contentMode: )
         Image("Example")
         .resizable()
         .aspectRatio(contentMode: .fit)
         //            .aspectRatio(contentMode: .fill)
         .frame(width: 300, height: 300)
         
         */
        
        /* GeometryReader
         GeometryReader{ geo in
         Image("Example")
         .resizable()
         .aspectRatio(contentMode: .fit)
         .frame(width: geo.size.width)
         */
        
        }
        

    }
}
 */

/*  ScrollView
 struct ContentView: View {
 
 struct CustomText: View {
 @State var text: String
 
 var body: some View{
 Text("\(text)")
 }
 
 init(text: String) {
 print("Creating a new custom text")
 self.text = text
 }
 }
 
 var body: some View{
 // ScrollView creates all views at one time
 ScrollView(.vertical){
 VStack(spacing: 10){
 ForEach(1..<100){
 CustomText(text: "Item \($0)")
 .font(.title)
 }
 }
 /* List creates View only when necessary
 List{
 ForEach(1..<100){
 CustomText(text: "Item \($0)")
 .font(.title)
 }
 */
 
 // Make the whole area scrollable
 .frame(maxWidth: .infinity)
 }
 
 //
 
 
 }
 }
 
 */

/*  NavigationView
 struct ContentView: View{
 var body: some View{
 NavigationView{
 VStack{
 NavigationLink(destination: Text("detail view")){
 Text("text")
 }
 // List with NavigationLink will make an indicator
 List(0..<100){ row in
 NavigationLink(destination: Text("Detail \(row)")){
 Text("Row \(row)")
 }
 }
 }
 .navigationTitle("SwiftUI")
 }
 }
 }
 
 */

/* Working with hierarchical codable data
 struct ContentView: View{
 struct Address:Codable {
 var street: String
 var city: String
 }
 
 struct User:Codable {
 var name: String
 var address: Address
 }
 
 var body: some View{
 Button("Decode JSON"){
 let input = """
 {
 "name": "Taylor Swift",
 "address": {
 "street": "555, Taylor Swift Avenue",
 "city": "Nashville"
 }
 }
 """
 let data = Data(input.utf8)
 let decoder = JSONDecoder()
 if let user = try? decoder.decode(User.self, from: data){
 print(user.address.street)
 print(user.address.city)
 print(user.name)
 }
 }
 }
 
 }
 
 */

/*  Loading a specific kind of codable data
 let astronauts = Bundle.main.decode("astronauts.json")
 
 struct ContentView: View{
 var body: some View{
 Text("\(astronauts.count) astronauts found")
 }
 }
 
 */

struct ContentView: View{
    var astronauts:[Astronaut] = Bundle.main.decode("astronauts.json")
    var missions:[Mission] = Bundle.main.decode("missions.json")
    var body: some View{
        NavigationView{
            List(missions){ mission in
                NavigationLink(destination: Text("Detail view")){
                    Image(mission.imageS)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                    
                    VStack{
                        Text(mission.displayedName)
                            .font(.headline)
                        Text(mission.formattedLaunchDate)
                    }
                }
            }
            .navigationBarTitle("Moonshot")
            
            
        }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

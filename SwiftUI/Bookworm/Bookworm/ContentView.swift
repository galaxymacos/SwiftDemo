//
//  ContentView.swift
//  Bookworm
//
//  Created by Xun Ruan on 2021/7/12.
//

import SwiftUI
import CoreData

struct PushButton: View {
    var title = "Push"
    @Binding var isOn:Bool
    var onColor = [Color.red, Color.yellow]
    var offColor = [Color(white: 0.6), Color(white: 0.4)]
    
    var body: some View{
        Button(title){
            isOn.toggle()
        }
        .padding()
        .background(LinearGradient(gradient: isOn ? Gradient(colors: [onColor[0], onColor[1]]):Gradient(colors: [offColor[0], offColor[1]]), startPoint: .top, endPoint: .bottom))
        .foregroundColor(.white)
        .clipShape(Capsule())
        .shadow(radius: isOn ? 0 : 5)
    }
}



struct ContentView: View {
    /* Unknown core data stuff
     @Environment(\.managedObjectContext) private var viewContext
     
     @FetchRequest(
     sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
     animation: .default)
     private var items: FetchedResults<Item>
     
     var body: some View {
     List {
     ForEach(items) { item in
     Text("Item at \(item.timestamp!, formatter: itemFormatter)")
     }
     .onDelete(perform: deleteItems)
     }
     .toolbar {
     #if os(iOS)
     EditButton()
     #endif
     
     Button(action: addItem) {
     Label("Add Item", systemImage: "plus")
     }
     }
     */
    
    /* two-way binding
     @State var rememberMe: Bool = false
     var body: some View{
     VStack{
     PushButton(title: "Remember me?", isOn: $rememberMe)
     Text("\(rememberMe ? "On":"Off")")
     }
     }
     */
    
    /* Sizeclass
     @Environment(\.horizontalSizeClass) var sizeClass
     var body: some View{
     if sizeClass == .compact{
     VStack{
     Text("Size class is compact")
     .font(.largeTitle)
     Text("placeholder")
     }
     }
     else{
     HStack{
     Text("Size class is regular")
     .font(.largeTitle)
     Text("placeholder")
     }
     
     }
     }
     */
    
    @FetchRequest(entity: Student.entity(), sortDescriptors: []) var students: FetchedResults<Student>
    
    @Environment(\.managedObjectContext) var moc    // for adding and saving objects
    
    var body: some View{
        VStack{
            Button("Add"){
                let firstNames = ["Ginny", "Harry", "Hermione", "Luna", "Ron"]
                let lastNames = ["Granger", "Lovegood", "Potter", "Weasley"]
                
                let chosenFirstName:String = firstNames.randomElement()!
                let chosenLastName:String = lastNames.randomElement()!
                
                let student = Student(context: moc)
                student.id = UUID()
                student.name = "\(chosenFirstName) \(chosenLastName)"
                
                try? self.moc.save()
            }
            List{
                ForEach(students, id: \.id){ student in
                    Text("Student name: \(student.name ?? "None")")
                }
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

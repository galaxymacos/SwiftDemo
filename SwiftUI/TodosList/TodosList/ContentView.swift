//
//  ContentView.swift
//  TodosList
//
//  Created by Xun Ruan on 2021/7/13.
//

import SwiftUI
import CoreData

struct Test {
    let task: Task
}

// NSManagedObject conforms to ObservableObject
class Test2: NSManagedObject{
    // type: objectwillchange
}


// It is a child of TodosListApp
struct ContentView: View {
    // Think of it as a scratch pad, we need to save it
    @Environment(\.managedObjectContext) private var viewContext
    
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Task.date, ascending: false)])
    var tasks: FetchedResults<Task>
    
    var body: some View {
        NavigationView{
            List{
                ForEach(tasks, id: \.self){ task in
                    Text(task.title ?? "Notitle")
                        .onTapGesture(count: 1) {
                            updateTask(task)
                        }
                }.onDelete(perform: deleteTasks)
            }
            .navigationTitle(Text("TODO List📝"))
            .navigationBarItems(trailing: Button("Add task"){
                addTask()
            })
        }
    }
    
    private func addTask(){
        withAnimation{
            // Since Task doesn't exist as a class/struct in SwiftUI, we need to use context to instantiate it using the data in moc
            let newTask = Task(context: viewContext)
            newTask.title = "New task: \(Date())"
            newTask.date = Date()
//
            saveContext()
            
        }
    }
    
    private func updateTask(_ task:  FetchedResults<Task>.Element){
        task.title = "update title"
        saveContext()
    }
    
    // map will change one sequence into another sequence
    // foreach will map each element into a function
    private func deleteTasks(at offsets: IndexSet){
        offsets.map{tasks[$0]}.forEach(viewContext.delete)
        saveContext()
    }
    
    private func saveContext(){
        do{
            try viewContext.save()
        }catch{
            let error = error as NSError
            fatalError("Unresolved error: \(error)")
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

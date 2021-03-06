//
//  ContentView.swift
//  BookWormFix
//
//  Created by Xun Ruan on 2021/7/13.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State var showingAddScreen = false
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Book.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Book.title, ascending: true), NSSortDescriptor(keyPath: \Book.author, ascending: true)]) var books: FetchedResults<Book>
    
    var body: some View{
        NavigationView{
            List{
                ForEach(books, id: \.self){ book in
                    NavigationLink(destination: DetailView(book: book)){
                        EmojiRatingView(rating: book.rating)
                            .font(.largeTitle)
                        VStack{
                            Text(book.title ?? "Unknown title")
                                .font(.headline)
                                .foregroundColor(book.rating == 1 ? .red : .black)
                            Text(book.author ?? "Unknown author")
                                .foregroundColor(.secondary)
                        }
                    }
                }.onDelete(perform: deleteBooks)
            }
            .navigationBarItems(leading: EditButton(), trailing: Button(action: {self.showingAddScreen.toggle()}, label: {
                Image(systemName: "plus")
            }))
            .navigationBarTitle("Bookworm")
            .sheet(isPresented: $showingAddScreen, content: {
                AddBookView().environment(\.managedObjectContext, moc)
            })
        }
    }
    
    // send the delete request from local to Internet
    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            let book = books[offset]
            moc.delete(book)
        }
        try? moc.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

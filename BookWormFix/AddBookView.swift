//
//  AddBookView.swift
//  BookWormFix
//
//  Created by Xun Ruan on 2021/7/13.
//

import SwiftUI



struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @State var title = ""
    @State var author = ""
    @State var rating = 3
    @State var genre = ""
    @State var review = ""
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)
                    
                    Picker("Genre", selection: $genre){
                        ForEach(genres, id: \.self){
                            Text($0)
                        }
                    }
                    
                }
                
                Section{
                    Picker("Rating", selection: $rating){
                        ForEach(0..<6){
                            Text("\($0)")
                        }
                    }
                    
                    TextField("Write a review", text: $review)
                }
                
                Section{
                    Button("Save"){
                        let book = Book(context: moc)
                        book.title = title
                        book.author = author
                        book.rating = Int16(rating)
                        book.genre = genre
                        book.review = review
                        
                        try? moc.save()
                        
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .navigationBarTitle("Add book")
            
        }
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}

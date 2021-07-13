//
//  DetailView.swift
//  BookWormFix
//
//  Created by Xun Ruan on 2021/7/13.
//

import SwiftUI
import CoreData

struct DetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var moc
    @State private var showingDeleteAlert = false
    
    var book: Book
    
    
    var body: some View {
        NavigationView{
            GeometryReader{ geometry in
                VStack {
                    ZStack(alignment: .bottomTrailing) {
                        
                        Image(self.book.genre ?? "Fantasy")
                            .frame(maxWidth: geometry.size.width)

                        Text(self.book.genre?.uppercased() ?? "FANTASY")
                            .font(.caption)
                            .fontWeight(.black)
                            .padding(8)
                            .foregroundColor(.white)
                            .background(Color.black.opacity(0.75))
                            .clipShape(Capsule())
                            .offset(x: -5, y: -5)
                    }
                    Text(self.book.author ?? "Unknown author")
                        .font(.title)
                        .foregroundColor(.secondary)

                    Text(self.book.review ?? "No review")
                        .padding()

                    RatingView(rating: .constant(Int(self.book.rating)))
                        .font(.largeTitle)

                    Spacer()
                }
                
            }
            .alert(isPresented: $showingDeleteAlert){
                Alert(title: Text("Are you sure"), message: Text("You want to delete the book"), primaryButton: .destructive(Text("Delete")){
                    deleteBook()
                }, secondaryButton: .cancel())
            }
            .navigationBarTitle(Text(book.title ?? "Unknown book"), displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {showingDeleteAlert = true}){
                Image(systemName: "trash")
            })
        }
    }
    
    func deleteBook(){
        
        moc.delete(book)
        
        try? moc.save()
        
        presentationMode.wrappedValue.dismiss()
    }
}

struct DetailView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    static var previews: some View {
        let book = Book(context: moc)
        book.title = "Back to Earth"
        book.author = "Xun Ruan"
        book.genre = "Kids"
        book.rating = 5
        book.review = "A book about Earth"
        return NavigationView{
                DetailView(book: book)
            }
        
        
    }
}

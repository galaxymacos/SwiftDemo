//
//  DetailView.swift
//  BookWormFix
//
//  Created by Xun Ruan on 2021/7/13.
//

import SwiftUI
import CoreData

struct DetailView: View {
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
            .navigationBarTitle(Text(book.title ?? "Unknown book"), displayMode: .inline)
        }
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

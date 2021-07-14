//
//  FilteredListGenerics.swift
//  CoreDataProject
//
//  Created by Xun Ruan on 2021/7/14.
//

import SwiftUI
import CoreData

struct FilteredListGenerics<T: NSManagedObject, Content: View>: View {
    var fetchedRequest: FetchRequest<T>
    var fetchedResults: FetchedResults<T>{
        fetchedRequest.wrappedValue
    }
    
    // call this on every item in the list
    let content: (T) -> Content
    
    init(filterKey: String, filterValue: String, @ViewBuilder content: @escaping (T) -> Content){
        fetchedRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: [], predicate: NSPredicate(format: "%K BEGINSWITH %@", filterKey, filterValue))
        self.content = content
    }
    
    var body: some View {
        List(fetchedResults, id: \.self){ item in
            content(item)
        }
    }
}

struct FilteredListGenerics_Previews: PreviewProvider {
    static var previews: some View {
        FilteredListGenerics(filterKey: "lastName", filterValue: "A", content: {
            (singer: Singer) in
            Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
        })
    }
}

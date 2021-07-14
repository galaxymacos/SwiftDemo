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
    
    init(filterKey: String, filterValue: String, sortDescriptors: [NSSortDescriptor], predicateType: predicate,predicateArgs:[String], @ViewBuilder content: @escaping (T) -> Content){
        switch predicateType {
        case .BEGINSWITH:
            fetchedRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: sortDescriptors, predicate: NSPredicate(format: "%K BEGINSWITH %@", filterKey, filterValue))
        case .CONTAINS:
            fetchedRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: sortDescriptors, predicate: NSPredicate(format: "%K CONTAINS %@", filterKey, filterValue))
        case .IN:
            fetchedRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: sortDescriptors, predicate: NSPredicate(format: "%K IN %@", filterKey, predicateArgs))
        }
        self.content = content
    
    }
    
    var body: some View {
        List(fetchedResults, id: \.self){ item in
            content(item)
        }
    }
}

enum predicate{
    case BEGINSWITH, IN, CONTAINS
}

struct FilteredListGenerics_Previews: PreviewProvider {
    static var previews: some View {
        FilteredListGenerics(filterKey: "firstName", filterValue: "A", sortDescriptors: [], predicateType: .BEGINSWITH, predicateArgs: [""], content: {
            (singer: Singer) in
            Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
        })
    }
}


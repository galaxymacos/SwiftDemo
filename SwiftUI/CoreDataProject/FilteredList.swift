//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Xun Ruan on 2021/7/14.
//

import SwiftUI

struct FilteredList: View {
    var fetchRequest: FetchRequest<Singer>
    
    // get what's in the fetech request
    var singers: FetchedResults<Singer>{
        fetchRequest.wrappedValue
    }
    
    init(filter: String) {
        fetchRequest = FetchRequest<Singer>(entity: Singer.entity(), sortDescriptors: [], predicate: NSPredicate(format: "lastName BEGINSWITH[c] %@", filter))
    }
    var body: some View {
        List(singers, id: \.self){ singer in
           Text(singer.wrappedFirstName + " " + singer.wrappedLastName)
        }
    }
}

struct FilteredList_Previews: PreviewProvider {
    static var previews: some View {
        FilteredList(filter: "A")
    }
}

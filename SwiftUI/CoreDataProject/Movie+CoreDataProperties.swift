//
//  Movie+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Xun Ruan on 2021/7/13.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    // We can delete the optional, but that will cause confusion in a long run
    
    @NSManaged public var title: String?
    public var wrappedTitle: String {
        return title ?? "Unknown title"
    }
    
    @NSManaged public var director: String?
    @NSManaged public var year: Int16

}

extension Movie : Identifiable {

}

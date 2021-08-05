//
//  Candy+CoreDataProperties.swift
//  CandyAndCountry
//
//  Created by Xun Ruan on 2021/7/14.
//
//

import Foundation
import CoreData


extension Candy {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Candy> {
        return NSFetchRequest<Candy>(entityName: "Candy")
    }

    @NSManaged public var name: String?
    var wrappedName: String{
        name ?? "Unknown name"
    }
    @NSManaged public var origin: Country?

}

extension Candy : Identifiable {

}

//
//  Singer+CoreDataProperties.swift
//  DynamicFilteringSinger
//
//  Created by Xun Ruan on 2021/7/14.
//
//

import Foundation
import CoreData


extension Singer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Singer> {
        return NSFetchRequest<Singer>(entityName: "Singer")
    }

    @NSManaged public var firstName: String?
    var wrappedFirstName: String{
        return firstName ?? "Unknown"
    }
    @NSManaged public var lastName: String?
    var wrappedLastName: String{
        return lastName ?? "Unknown"
    }

}

extension Singer : Identifiable {

}

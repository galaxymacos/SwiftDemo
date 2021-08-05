//
//  Singer+CoreDataProperties.swift
//  CoreDataProject
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

    @NSManaged public var lastName: String?
    var wrappedLastName: String{
        lastName ?? "No last name"
    }
    @NSManaged public var firstName: String?
    var wrappedFirstName: String{
        firstName ?? "No first name"
    }

}

extension Singer : Identifiable {

}

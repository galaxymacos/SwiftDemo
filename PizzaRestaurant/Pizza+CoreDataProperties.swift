//
//  Pizza+CoreDataProperties.swift
//  PizzaRestaurant
//
//  Created by Xun Ruan on 2021/7/13.
//
//

import Foundation
import CoreData


extension Pizza {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Pizza> {
        return NSFetchRequest<Pizza>(entityName: "Pizza")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var numOfSlices: Int16
    @NSManaged public var tableNumber: String?
    @NSManaged public var status: String?
    @NSManaged public var pizzaType: String?

}

extension Pizza : Identifiable {

}

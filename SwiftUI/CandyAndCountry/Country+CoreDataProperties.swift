//
//  Country+CoreDataProperties.swift
//  CandyAndCountry
//
//  Created by Xun Ruan on 2021/7/14.
//
//

import Foundation
import CoreData


extension Country {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Country> {
        return NSFetchRequest<Country>(entityName: "Country")
    }

    @NSManaged public var fullName: String?
    var wrappedFullName: String{
        fullName ?? "No name"
    }
    @NSManaged public var shortName: String?
    var wrappedShortName: String{
        shortName ?? "No name"
    }
    @NSManaged public var candy: NSSet?

    var candyArray: [Candy]{
        let set = candy as? Set<Candy> ?? []
        return set.sorted{
            $0.wrappedName < $1.wrappedName
        }
    }
}

// MARK: Generated accessors for candy
extension Country {

    @objc(addCandyObject:)
    @NSManaged public func addToCandy(_ value: Candy)

    @objc(removeCandyObject:)
    @NSManaged public func removeFromCandy(_ value: Candy)

    @objc(addCandy:)
    @NSManaged public func addToCandy(_ values: NSSet)

    @objc(removeCandy:)
    @NSManaged public func removeFromCandy(_ values: NSSet)

}

extension Country : Identifiable {

}

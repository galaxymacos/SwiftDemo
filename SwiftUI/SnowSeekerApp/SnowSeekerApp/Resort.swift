//
//  Resort.swift
//  SnowSeekerApp
//
//  Created by Xun Ruan on 2021/7/26.
//

struct Resort: Codable, Identifiable {
    var id: String
    var name: String
    var country: String
    var description: String
    var imageCredit: String
    var price: Int
    var size: Int
    var snowDepth: Int
    var elevation: Int
    let runs: Int
    let facilities: [String]
    
    static var example: Resort{
        ContentView.randomResort
    }
    
    // Sorter Related
    static var currentSorter = SortBy.none
    
    // Filter Related
    static var filterCountry: String? = nil
    static var filterLowestPrice: Int? = nil
    static var filterHighestPrice: Int? = nil
    static var filterSmallestSize: Int? = nil
    static var filterLargestSize: Int? = nil
    
    
    
    var facilityTypes: [Facility] {
        // The id must be marked as let, or the init will need us to instantiate it as well
        facilities.map(Facility.init)
    }
}

enum FilterBy{
    case country
    case size
    case price
    case none
}

enum SortBy{
    case alphabetical
    case country
    case none
}

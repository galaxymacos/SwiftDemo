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
    
    var facilityTypes: [Facility] {
        // The id must be marked as let, or the init will need us to instantiate it as well
        facilities.map(Facility.init)
    }
}


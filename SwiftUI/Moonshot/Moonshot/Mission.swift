//
//  Mission.swift
//  Moonshot
//
//  Created by Xun Ruan on 2021/7/8.
//

import Foundation

struct CrewRole: Codable{
    let name: String
    let role: String
}

struct Mission: Identifiable, Codable {
    let id: Int
    let launchDate: Date?
    // A string representation of the launch date
    var formattedLaunchDate: String {
        if let launchDate = launchDate{
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .long
            return dateFormatter.string(from: launchDate)
        }
        return "N/A"
    }
    let crew: [CrewRole]
    let description: String
    
    var displayedName: String{
        "Apollo \(id)"
    }
    
    var imageS: String{
        "apollo\(id)"
    }
    
    
}



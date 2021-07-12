//
//  Order.swift
//  CupcakeCorner
//
//  Created by Xun Ruan on 2021/7/12.
//

import SwiftUI

struct OrderDetail: Codable{
    static let types = ["Vanilla", "Strawberry", "chocolate", "rainbow"]
    
    var type = 0
    var quantity = 3
    
    var specialRequestEnabled = false{
        didSet{
            if specialRequestEnabled == false{
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    
    var addSprinkles = false
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
}

// Codable won't work on @Published variable by default
class Order: ObservableObject, Codable {
    static let types = ["Vanilla", "Strawberry", "chocolate", "rainbow"]
    
    @Published var type = 0
    @Published var quantity = 3
    
    @Published var specialRequestEnabled = false{
        didSet{
            if specialRequestEnabled == false{
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    @Published var extraFrosting = false
    
    @Published var addSprinkles = false
    
    @Published var name = ""
    @Published var streetAddress = ""
    @Published var city = ""
    @Published var zip = ""
    
    enum CodingKeys: CodingKey {
        case type, quantity, specialRequestEnabled, extraFrosting, addSprinkles, name, streetAddress, city, zip
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type, forKey: .type)
        try container.encode(quantity, forKey: .quantity)
        
        try container.encode(extraFrosting, forKey: .extraFrosting)
        try container.encode(addSprinkles, forKey: .addSprinkles)
        
        try container.encode(name, forKey: .name)
        try container.encode(streetAddress, forKey: .streetAddress)
        try container.encode(city, forKey: .city)
        try container.encode(zip, forKey: .zip)
    }
    
    init() {
        
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
            type = try container.decode(Int.self, forKey: .type)
            quantity = try container.decode(Int.self, forKey: .quantity)

            extraFrosting = try container.decode(Bool.self, forKey: .extraFrosting)
            addSprinkles = try container.decode(Bool.self, forKey: .addSprinkles)

            name = try container.decode(String.self, forKey: .name)
            streetAddress = try container.decode(String.self, forKey: .streetAddress)
            city = try container.decode(String.self, forKey: .city)
            zip = try container.decode(String.self, forKey: .zip)
    }
    
    var hasValidAddress: Bool {
        if streetAddress.trimmingCharacters(in: .whitespacesAndNewlines).count == 0{
            return false
        }
        return !name.isEmpty && !city.isEmpty && !zip.isEmpty
    }
    
    var price: Double{
        var total = 0.0
        total += Double(type) / 2.0
        total += Double(quantity) * 2.0
        if(extraFrosting){
            total += 1
        }
        if(addSprinkles){
            total += 0.5
        }
        return total
    }
    
    
}

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
    
    init() {
        
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

// Codable won't work on @Published variable by default
class Order: ObservableObject, Codable {

    @Published var orderDetail: OrderDetail = OrderDetail()
    
    enum CodingKeys: CodingKey {
        case orderDetail
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(orderDetail, forKey: .orderDetail)
    }
    
    init() {
        
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
            orderDetail = try container.decode(OrderDetail.self, forKey: .orderDetail)
            
    }
    
    var hasValidAddress: Bool {
        if orderDetail.streetAddress.trimmingCharacters(in: .whitespacesAndNewlines).count == 0{
            return false
        }
        return !orderDetail.name.isEmpty && !orderDetail.city.isEmpty && !orderDetail.zip.isEmpty
    }
   
    
    
}

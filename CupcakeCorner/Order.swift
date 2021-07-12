//
//  Order.swift
//  CupcakeCorner
//
//  Created by Xun Ruan on 2021/7/12.
//

import SwiftUI

class Order: ObservableObject {
    static let types = ["Vanilla", "Strawberry", "chocolate", "rainbow"]
    
    var type = 0
    var quantity = 3
    
    @Published var specialRequestEnabled = false{
        didSet{
            if specialRequestEnabled == false{
                extraTopping = false
                addSprinkles = false
            }
        }
    }
    @Published var extraTopping = false
    @Published var addSprinkles = false
    
    @Published var name = ""
    @Published var streetAddress = ""
    @Published var city = ""
    @Published var zip = ""
    
    var hasValidAddress: Bool {
        return !name.isEmpty && !streetAddress.isEmpty && !city.isEmpty && !zip.isEmpty
    }
    
    var price: Double{
        var total = 0.0
        total += Double(type) / 2.0
        total += Double(quantity) * 2.0
        if(extraTopping){
            total += 1
        }
        if(addSprinkles){
            total += 0.5
        }
        return total
    }
}

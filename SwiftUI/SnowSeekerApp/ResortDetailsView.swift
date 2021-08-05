//
//  ResortDetailsView.swift
//  SnowSeekerApp
//
//  Created by Xun Ruan on 2021/7/27.
//

import SwiftUI

struct ResortDetailsView: View {
    let resort: Resort
    var size: String{
        switch resort.size {
        case 1:
            return "Small"
        case 2:
            return "Average"
        default:
            return "Large"
        }
    }
    var price: String{
        String(repeating: "$", count: resort.price)
    }
    var body: some View {
        Group{
            // We have two views because we can then use VStack or HStack to wrap those views later
            Text("Price: \(price)").layoutPriority(1)
            Spacer().frame(height: 0)
            Text("Size: \(size)").layoutPriority(1)
            
        }
    }
}

struct ResortDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ResortDetailsView(resort: Resort.example)
    }
}

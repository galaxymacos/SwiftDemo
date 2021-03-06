//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Xun Ruan on 2021/7/12.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: Order
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    TextField("Name", text: $order.orderDetail.name)
                    TextField("Street address", text: $order.orderDetail.streetAddress)
                    TextField("Zip", text: $order.orderDetail.zip)
                    TextField("City", text: $order.orderDetail.city)
                }
                
                Section{
                    NavigationLink(destination: CheckoutView(order: order)){
                        Text("Check out")
                    }
                }
                .disabled(!order.hasValidAddress)
            }
            .navigationBarTitle("Delivery details", displayMode: .inline)
        }
        
        
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: Order())
    }
}

//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Xun Ruan on 2021/7/12.
//

import SwiftUI

struct CheckoutView: View {
    @State var order: Order
    var body: some View {
        NavigationView{
            GeometryReader{ geo in
                ScrollView{
                    VStack{
                        Image("cupcakes")
                            .resizable()
                            .scaledToFit()
                            .frame(width: geo.size.width)
                        
                        // show total price
                        Text("Total price: \(order.price, specifier: "%.2f")")
                        // checkout button
                        Button("Checkout"){
                            //
                        }
                    }
                }
                
            }
            .navigationBarTitle("Checkout", displayMode: .inline)
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}

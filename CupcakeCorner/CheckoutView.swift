//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Xun Ruan on 2021/7/12.
//

import SwiftUI

struct CheckoutView: View {
    @State var order: Order
    
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    
    @State private var errorMessage = "Network error"
    @State private var showErrorMessage = false
    
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
                        Text("Total price: \(order.orderDetail.price, specifier: "%.2f")")
                        // checkout button
                        Button("Checkout"){
                            placeOrder()
                        }
                        .padding()
                    }
                }
                
            }
            .navigationBarTitle("Checkout", displayMode: .inline)
            .alert(isPresented: $showingConfirmation) {
                Alert(title: Text("Thank you!"), message: Text(confirmationMessage), dismissButton: .default(Text("OK")))
            }
        }
        .alert(isPresented: $showErrorMessage, content: {
            Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
        })
    }
    
    func placeOrder() {
        // Step 1: Encode the data
        guard let encodedData = try? JSONEncoder().encode(order) else{
            print("Can't encode data")
            showErrorMessage = true
            return
        }
        
        // Step 2: Create a URL request
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encodedData
        
        
        
        // Step 3: Retrieve data from url
        URLSession.shared.dataTask(with: request){ data, response, error in
            guard let data = data else{
                print("Can't retrieve data. Error: \(error?.localizedDescription ?? "Unknown error")")
                showErrorMessage = true
                return
            }
            if let decodedOrder = try? JSONDecoder().decode(Order.self, from: data){
                confirmationMessage = "You have placed an order of \(decodedOrder.orderDetail.quantity) \(OrderDetail.types[decodedOrder.orderDetail.type]) ice cream"
                showingConfirmation = true
            }
            else{
                print("Decode failed")
                showErrorMessage = true
            }
        }.resume()
        
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}

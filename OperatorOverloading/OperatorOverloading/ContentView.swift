//
//  ContentView.swift
//  OperatorOverloading
//
//  Created by Xun Ruan on 2021/7/18.
//

import SwiftUI

struct ContentView: View {
    var myWrappedValue = NonNegative(wrappedValue: -10)
    @NonNegative var myWrapper = -20
    
    var body: some View {
        VStack{
            Text("My wrapped struct: \(myWrappedValue.wrappedValue)")
                .padding()
            Text("MyWrapper: \(myWrapper)")
                .padding()
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


extension BinaryInteger{
    // Self is the type of self
    static func * (lhs: Self, rhs: CGFloat) -> CGFloat{
        return CGFloat(lhs) * rhs
    }
    
    static func * (lhs: CGFloat, rhs: Self) -> CGFloat{
        return lhs * CGFloat(rhs)
    }
    
    static func * (lhs: Self, rhs: Double) -> Double{
        return Double(lhs) * rhs
    }
    
    static func * (lhs: Double, rhs: Self) -> Double{
        return lhs * Double(rhs)
    }
}

// Create a non-negative property wrapper

@propertyWrapper
struct NonNegative<Value: BinaryInteger> {
    var value: Value
    
    init(wrappedValue: Value) {
        if(wrappedValue < 0){
            value = 0
        }
        else{
            value = wrappedValue
        }
    }
    
    var wrappedValue: Value{
        get{
            return value
        }
        set{
            if newValue < 0{
                value = 0
            }
            else{
                value = newValue
            }
        }
    }
    
    
}

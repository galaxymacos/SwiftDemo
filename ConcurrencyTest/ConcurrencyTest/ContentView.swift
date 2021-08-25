//
//  ContentView.swift
//  ConcurrencyTest
//
//  Created by 阮迅 on 2021/8/25.
//

import SwiftUI

struct ContentView: View {
    
    let calculatePrimeOperation = CalculatePrimeOperation()
    @State var backgroundTaskRunning = false
    
    var body: some View {
        VStack{
            Spacer()
            DatePicker(selection: .constant(Date()), label: {Text("Date")})
                .labelsHidden()
            Button(action: calculatePrimes, label: {
                Text("Calculate Primes")
            })
            .disabled(backgroundTaskRunning)
            Spacer()
        }
    }
    
    
    func calculatePrimes(){
        backgroundTaskRunning = true
        // MARK: - Using GCD -
        DispatchQueue.global(qos: .userInitiated).async {
            for number in 0...1_000_000{
                let isPrimeNumber = self.isPrime(number: number)
                print("\(number) is prime: \(isPrimeNumber)")
            }
//            DispatchQueue.main.async {
                backgroundTaskRunning = false
//            }
        }
        
        // MARK: - Using OperationQueue -
//        let queue = OperationQueue()
        
        // MARK: - A more sophsticated way for complex operations
//        queue.addOperation(calculatePrimeOperation)
        
        // MARK: - A more elegant way for simpler operations
//        queue.addOperation {
//            for number in 0...1_000_000{
//                let isPrimeNumber = self.isPrime(number: number)
//                print("\(number) is prime: \(isPrimeNumber)")
//            }
//        }
    }
    
    
    func calculatePrime(){
        for number in 0...1_000_000{
            let isPrimeNumber = isPrime(number: number)
            print("\(number) is prime: \(isPrimeNumber)")
        }
    }
    
    func isPrime(number: Int) -> Bool {
        if number <= 1{
            return false
        }
        
        if number <= 3{
            return true
        }
        
        var i = 2
        while i * i <= number{
            if number % i == 0{
                return false
            }
            i = i + 2
        }
        return true
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

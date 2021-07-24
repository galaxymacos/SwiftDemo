import UIKit
import SwiftUI
import Combine

// Just publishes a single value and immediately finishes!
Just(1)
Just("Hello world")


    let url = URL(string: "https://www.apple.com/")
    if let url = url{
        URLSession.shared.dataTaskPublisher(for: url)
    }


Timer.publish(every: 1, on: .main, in: .default)

class RandomClass: ObservableObject{
    @Published var randomNumber = 1
    
}

// To access the underlying publisher, we use '$' sign
var randomClass = RandomClass()
randomClass.$randomNumber

// key path subscribers

class SomeViewModel: ObservableObject{
    var someNumber: Int = 0
    
    init(){
        Just(9)
            // A subscriber that directly assign the published value to a variable
            .assign(to: \.someNumber, on: self)
//            .cancel()
        
        Just(10)
            // A subscriber that allows us to do something with the published variable
            .sink{ value in
                print("The value published is \(value)")
                self.someNumber = value
            }.cancel()
        
    }
}

var yo = SomeViewModel()
print(yo.someNumber)

var cancellable:AnyCancellable?
let ptSubject = PassthroughSubject<String, Never>()
ptSubject.send("Hello") // broadcast a message from the publisher
    // add a subscriber to the passthroughsubject publisher
cancellable = ptSubject.sink{str in
    print(str)
}
ptSubject.send("world")

let cvSubject = CurrentValueSubject<String, Never>("hello")
var anyCancellableForCvSubject = cvSubject.sink{ currentValue in
    print("The current value is \(currentValue)")
}
cvSubject.send("world")


// Publisher -> Operator -> Subscriber
class RandomClass2{ // This class acts like a subscriber
    @Published var randomNumber = 0
    
    init(){
        Just("9")
            .map{
                Int($0) ?? 0
            }
            .assign(to: \.randomNumber, on: self)
            .cancel()
    }
}



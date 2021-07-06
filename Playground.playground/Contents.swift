import SwiftUI

List{
    Text("Static test 1")
    ForEach(0..<5){
        Text("This is dynamic test \($0)")
    }
    Text("Static test 2")
}.listStyle(GroupedListStyle())

// If a list is entirely made with a kind of element
List(0..<5){
    Text("Element \($0)")
}

// use id
var people = ["Mario", "Peach", "Captain", "ghost"]
List(people, id: \.self){
    Text($0)
}.listStyle(GroupedListStyle())

// Same as
List{
    ForEach(people, id: \.self){
        Text($0)
    }
}


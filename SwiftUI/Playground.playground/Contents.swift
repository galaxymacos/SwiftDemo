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

var erge = "a b c"
erge.components(separatedBy: " ")
var longLetter =
"""
a
b
c
"""
var target = longLetter.components(separatedBy: "\n")
var laji = target.randomElement()

var aStringNeedToTrim = " ovipfer  flcoif "
aStringNeedToTrim.trimmingCharacters(in: .whitespacesAndNewlines)

let wordToBeChecked = "swift"
let range = NSRange(location: 0, length: wordToBeChecked.utf16.count)
let checker = UITextChecker()
let misSpellRange = checker.rangeOfMisspelledWord(in: wordToBeChecked, range: range, startingAt: 0, wrap: false, language: "en")
let allgood = misSpellRange.location == NSNotFound

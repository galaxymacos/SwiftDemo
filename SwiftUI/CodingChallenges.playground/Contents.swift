import SwiftUI

func findDuplicate(str: String)->Bool{
    var set = Set<String.Element>()
    for letter in str {
        if set.contains(letter){
            return true
        }
        set.insert(letter)
    }
    return false
}

findDuplicate(str: "No duplicates")


// A smarter way to find duplicate
func findDuplicate2(str: String)->Bool{
    return Set(str).count != str.count
}

findDuplicate2(str: "nonono")

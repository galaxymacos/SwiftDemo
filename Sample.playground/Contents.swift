import UIKit


class Garbage {
    var toy = false {
        didSet {
            toy
            oldValue
        }
        willSet {
            toy
            newValue
        }
    }
}

let garbage = Garbage()
// MARK: No longer play toy when grown up
garbage.toy = true

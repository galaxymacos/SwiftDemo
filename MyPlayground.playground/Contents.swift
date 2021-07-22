import UIKit
import SwiftUI

class Demo{
    var name = ""
    init() throws {
        name = "Xun Ruan"
    }
}

do{
    var myDemo = try Demo()
    myDemo.name
}
catch{
    error.localizedDescription
}


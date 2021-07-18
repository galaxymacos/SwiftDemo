import SwiftUI

let exampleInt: Int64 = 50_000_000_000_000_001
print(exampleInt)

let result = Double(exampleInt) * 1.0
print(String(format: "%.0f", result))

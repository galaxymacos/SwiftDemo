import UIKit

let sharedSession = URLSession.shared   // MARK: Get the session singleton
sharedSession.configuration.allowsCellularAccess    // MARK: - Readonly
sharedSession.configuration.allowsCellularAccess = false
sharedSession.configuration.allowsCellularAccess


// MARK: Create my own configuration and change its property
let myDefaultConfiguration = URLSessionConfiguration.default
let eConfig = URLSessionConfiguration.ephemeral
let bConfig = URLSessionConfiguration.background(withIdentifier: "BackgroundConfigurationSession")

myDefaultConfiguration.allowsExpensiveNetworkAccess
myDefaultConfiguration.allowsExpensiveNetworkAccess = false
myDefaultConfiguration.allowsExpensiveNetworkAccess

// MARK: Create session using custom configuration
let customSession = URLSession(configuration: myDefaultConfiguration)
// MARK: Create session using default configuration
let defaultSession = URLSession(configuration: .default)
defaultSession.configuration.allowsCellularAccess

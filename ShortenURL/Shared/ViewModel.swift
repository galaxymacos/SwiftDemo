//
//  ViewModel.swift
//  ViewModel
//
//  Created by Xun Ruan on 2021/8/3.
//

import Foundation

// turn https://iosacademy.io
// to https://bit.ly/ios

struct Model: Hashable{
    let long: String
    let short: String
}

class ViewModel: ObservableObject{
    @Published var models = [Model]()
    
    func submit(urlString: String){
        guard URL(string: urlString) != nil else{
            return  // User enters nonsense
        }
        // Add URL
        guard let apiUrl = URL(string: "https://api.1pt.co/addURL?long=\(urlString)") else{
            return
        }
        
        // weak self means this data won't be gone if our ViewModel class doesn't exist anymore
        let task = URLSession.shared.dataTask(with: apiUrl){ [weak self] data, _, error in
            guard let data = data, error == nil else{
                return
            }
            // Convert data to JSON
            do{
                let result = try JSONDecoder().decode(APIResponse.self, from: data)
                let long = result.long
                let short = result.short
                DispatchQueue.main.async {
                    // If our class doesn't exist but our task is still running, don't visit our class to store data
                    self?.models.append(.init(long: long, short: short))
                }
            }catch{
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}

// Since the return data struct is like this
/*
 {
    "statis": 201,
    "message": "Added!",
    "short": "bmukb",
    "long": "http://apple.com"
 }
 */
// We write a struct to contain the data

struct APIResponse: Codable{
    let statis: Int
    let message: String
    let short: String
    let long: String
}

// https://api.1pt.co/addURL?long=https://apple.com

//
//  Bundle-Decodable.swift
//  Moonshot
//
//  Created by Xun Ruan on 2021/7/8.
//

import Foundation

extension Bundle{
    
    /*  Replaced by generic
     // from a file name, get the astronaut info list
     func decode(_ file: String) -> [Astronaut] {
         // Imagine url contains all the data
         guard let url = self.url(forResource: file, withExtension: nil) else {
             fatalError("Fail to locate \(file) on the disk")
         }

         // Codable uses Data we are instead going to use Data(contentsOf:)
         guard let data = try? Data(contentsOf: url) else{
             fatalError("Fail to load \(file)")
         }

         let decoder = JSONDecoder()
         guard let astronauts = try? decoder.decode([Astronaut].self, from: data) else{
             fatalError("Fail to decode \(file) from bundle.")
         }

         return astronauts
     }
     */
    
    
    
    /*  Replaced by generic
     func decodeMission(_ file:String) -> [Mission]{
     guard let url = self.url(forResource: file, withExtension: nil) else{
     fatalError("Fail to locate \(file) on the disk")
     }
     
     guard let data = try? Data(contentsOf: url) else{
     fatalError("Fail to load \(file)")
     }
     
     let decoder = JSONDecoder()
     guard let decoded = try? decoder.decode([Mission].self, from: data) else{
     fatalError("Fail to decode \(file) from bundle")
     }
     
     return decoded
     }
     
     */
    
    func decode<T: Codable>(_ file: String) -> T {
        // Imagine url contains all the data
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Fail to locate \(file) on the disk")
        }

        // Codable uses Data we are instead going to use Data(contentsOf:)
        guard let data = try? Data(contentsOf: url) else{
            fatalError("Fail to load \(file)")
        }

        let decoder = JSONDecoder()
        // Allow the decoder to decode the decode the date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "y-MM-dd"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        guard let astronauts = try? decoder.decode(T.self, from: data) else{
            fatalError("Fail to decode \(file) from bundle.")
        }

        return astronauts
    }
    
}

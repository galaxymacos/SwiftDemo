//
//  Person.swift
//  RememberNameBetter
//
//  Created by Xun Ruan on 2021/7/18.
//

import SwiftUI

struct Person: Codable, Hashable{
    enum CodingKeys: CodingKey{
        case firstName, lastName
    }
    var firstName: String
    var lastName: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        firstName = try container.decode(String.self, forKey: .firstName)
        lastName = try container.decode(String.self, forKey: .lastName)
        
        
    }
    
    func encode(to encoder: Encoder) throws {
        
    }
}

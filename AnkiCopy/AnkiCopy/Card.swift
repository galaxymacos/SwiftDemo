//
//  Card.swift
//  AnkiCopy
//
//  Created by Xun Ruan on 2021/7/21.
//

import Foundation

struct Card: Codable{
    var prompt: String
    var answer: String
    
    static var example: Card{
        Card(prompt: "Who is Steve Jobs", answer: "Steve Jobs")
    }
}

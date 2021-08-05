//
//  Result.swift
//  BucketListApp
//
//  Created by Xun Ruan on 2021/7/17.
//

struct Page: Codable, Comparable {
    let pageid: Int
    let title: String
    let terms: [String: [String]]?
    
    // get wikipedia description of the current page
    var description: String {
        return terms?["description"]?.first ?? "No further description"
    }
    
    static func <(lhs: Page, rhs: Page) -> Bool {
        return lhs.title < rhs.title
    }
    
    
}

struct Query:Codable {
    let pages: [Int: Page]
}

struct Result:Codable {
    let query: Query
}

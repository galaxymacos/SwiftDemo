//
//  Favorites.swift
//  SnowSeekerApp
//
//  Created by Xun Ruan on 2021/7/27.
//

import SwiftUI

class Favorites: ObservableObject{
    private var resorts: Set<String>
    
    private let saveKey = "Favorites"
    
    init(){
        // load data
        if let data = UserDefaults.standard.data(forKey: saveKey){
            if let decoded = try? JSONDecoder().decode(Set<String>.self, from: data)
            {
                resorts = decoded
                return
            }
        }
        
        resorts = []
    }
    
    func contains(_ resort: Resort)->Bool{
        return resorts.contains(resort.id)
    }
    
    func add(_ resort: Resort){
        // make UI reflect the change
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }
    
    func remove(_ resort: Resort){
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }
    
    func save(){
        if let data = try? JSONEncoder().encode(resorts){
            UserDefaults.standard.set(data, forKey: saveKey)
        }
        
    }
}

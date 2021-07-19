//
//  Saver.swift
//  SaveAndLoad
//
//  Created by Xun Ruan on 2021/7/18.
//

import SwiftUI

struct Saver {
    func saveAString(str: String, fileName: String){
        let url = getDocumentDirectory().appendingPathComponent(fileName)
        do{
            try str.write(to: url, atomically: true, encoding: String.Encoding.utf8)
            print("successfully saved")
        }
        catch{
            print(error.localizedDescription)
        }
    }
    
    private func getDocumentDirectory() -> URL{
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}



//
//  Loader.swift
//  SaveAndLoad
//
//  Created by Xun Ruan on 2021/7/18.
//

import SwiftUI

struct Loader{
    func readAString(fileNameWithoutExtension: String, fileExtension: String) -> String{
        if let stringUrl = Bundle.main.url(forResource: fileNameWithoutExtension, withExtension: fileExtension){
            let targetString = try? String(contentsOf: stringUrl)
            print("load success")
            return targetString ?? ""
        }
        print("load failed")
        return ""
    }
}

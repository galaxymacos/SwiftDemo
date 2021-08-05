//
//  ContentView.swift
//  SaveAndLoad
//
//  Created by Xun Ruan on 2021/7/18.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Result is "+stringTest())
            .padding()
        
    }
    

    func stringTest()->String{
        let saver = Saver()
        saver.saveAString(str: "hello world", fileName: "test.txt")
        let loader = Loader()
        let result = loader.readAString(fileNameWithoutExtension: "test", fileExtension: "txt")
        return result
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

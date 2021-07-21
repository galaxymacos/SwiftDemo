//
//  ContentView.swift
//  GetNotified
//
//  Created by Xun Ruan on 2021/7/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)){ _ in
                print("Moving to the background")
            }
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)){ _ in
                print("Enter foreground")
            }
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.userDidTakeScreenshotNotification)){_ in
                print("Screenshot taken")
            }
        
        // UIApplication.significantTimeChangeNotification
        // UIResponser.keyboardDidShowNotificaiton
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

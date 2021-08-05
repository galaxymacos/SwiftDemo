//
//  ContentView.swift
//  CustomContainer
//
//  Created by Xun Ruan on 2021-07-05.
//

import SwiftUI

struct ContentView: View {
    @State var agreedToTerm = false
    @State var agreedToPrivacyPolicy = false
    @State var agreedToEmails = false

    var body: some View{
        let binding = Binding<Bool>(
            get: {
                self.agreedToTerm && self.agreedToPrivacyPolicy && self.agreedToEmails
            },
            set:{
                self.agreedToEmails = $0
                self.agreedToTerm = $0
                self.agreedToPrivacyPolicy = $0
            }
        )
        
        VStack{
            Toggle(isOn: $agreedToTerm){
                Text("Agree to terms")
            }
            Toggle(isOn: $agreedToPrivacyPolicy){
                Text("Agree to privacy policy")
            }
            Toggle(isOn: $agreedToEmails){
                Text("Agree to emails")
            }
            Toggle(isOn: binding){
                Text("Agree to all")
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

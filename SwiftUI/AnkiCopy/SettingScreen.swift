//
//  SettingScreen.swift
//  AnkiCopy
//
//  Created by Xun Ruan on 2021/7/22.
//

import SwiftUI

struct SettingScreen: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var recoverCard: Bool
    var body: some View {
        NavigationView{
            VStack{
                Toggle("Review incorrect card", isOn:$recoverCard)
                    .padding()
                
            }
            .navigationBarTitle(Text("Settings"))
            .navigationBarItems(trailing: Button(action: {presentationMode.wrappedValue.dismiss()}, label: {
                Text("Return")
            }))
        }
    }
}

struct SettingScreen_Previews: PreviewProvider {
    static var previews: some View {
        SettingScreen(recoverCard: .constant(false))
    }
}

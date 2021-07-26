//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Xun Ruan on 2021/7/25.
//

import SwiftUI

struct NavigationviewDifferentBehavioriPhoneiPad: View {
    var body: some View {
        NavigationView{
            Text("Hello world")
                .navigationTitle("Primary")
            
            Text("Secondary")
        }
    }
}



struct SplitView_NavigationLink: View {
    var body: some View{
        NavigationView{
            NavigationLink(destination: Text("Second text")){
                Text("First View")
            }
            .navigationBarTitle("Primary")
            
            // This won't be shown
            Text("Second View")
        }
    }
}

struct Test_SheetAlert_Optional: View {
    
    struct User: Identifiable{
        var id = "Taylor swift"
    }
    
    @State var selectedUser:User? = nil
    var body: some View{
        Text("Hello world")
            .onTapGesture {
                selectedUser = User()
            }
            // it will automatically unwrap the optional value (You don't have to handle the force wrapping
            .alert(item: $selectedUser){user in
                Alert(title: Text("title"), message: Text("message"), dismissButton: .default(Text("Dismiss")))
            }
        
    }
}

struct ContentView: View {
    var body: some View{
        Test_SheetAlert_Optional()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

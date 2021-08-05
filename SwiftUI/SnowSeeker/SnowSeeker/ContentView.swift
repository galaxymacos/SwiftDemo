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

struct UserView: View {
    var body: some View{
        Group{
            Text("Name: Paul")
            Text("Country: England")
            Text("Pet: Luna, Arya and Toby")
        }
    }
}

struct ControlableLayout: View{
    @State var verticalLayout = false
    var body: some View{
        NavigationView{
            Group{
                if verticalLayout{
                    VStack{
                        UserView()
                    }
                }
                else{
                    HStack{
                        UserView()
                    }
                }
            }
            .navigationBarTitle("Controlable view")
            .navigationBarItems(trailing: Button(verticalLayout ? "Vertical" : "Horizontal"){
                verticalLayout.toggle()
            })
        }
    }
}

struct AutoSwitchLayoutForSizeClasses: View{
    @Environment(\.horizontalSizeClass) var sizeClass
    var body: some View{
        if sizeClass == .compact{
            VStack(content: UserView.init)
            // More concise than
//            VStack{
//                UserView()
//            }
        }
        else{
            HStack(content: UserView.init)
        }
    }
}

struct ContentView: View {
    var body: some View{
        AutoSwitchLayoutForSizeClasses()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

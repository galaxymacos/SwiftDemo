//
//  ContentView.swift
//  Shared
//
//  Created by Xun Ruan on 2021/7/16.
//

import SwiftUI
import LocalAuthentication

/* Adding conformance to Comparable for custom types
 struct User: Identifiable, Comparable {
 var id: UUID = UUID()
 var firstName: String
 var lastName: String
 
 static func < (user1: User, user2: User)->Bool{
 return user1.firstName < user2.firstName
 }
 }
 
 
 struct ContentView: View {
 let numbers = [1,5,3,6,2,9].sorted()
 
 // Thanks to the User struct being Comparable
 let users = [
 User(firstName: "Arnold", lastName: "Rimmer"),
 User(firstName: "Kristine", lastName: "Kochanski"),
 User(firstName: "David", lastName: "Lister"),
 ]
 // A better way
 .sorted()
 // This code is not reusable
 //    .sorted{
 //        $0.firstName<$1.firstName
 //    }
 
 var body: some View {
 List(users, id: \.id){
 Text("\($0.firstName) \($0.lastName)")
 }
 }
 }
 */

/* Writing data to the documents directory
 struct ContentView: View {
 var body: some View{
 Text("tap to save the load text")
 .onTapGesture {
 let test = "test"
 let url = FileManager.default.getDocumentsDirectory().appendingPathComponent("messsge.txt")
 do{
 try test.write(to: url, atomically: true, encoding: .utf8)
 let result = try String(contentsOf: url)
 print(result)
 }catch{
 print(error.localizedDescription)
 }
 }
 }
 }
 extension FileManager{
 func getDocumentsDirectory()->URL{
 let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
 return paths[0]
 }
 }
 */

/* Switch View state with enum
 struct ContentView: View {
 enum loadingState {
 case loading, success, failed
 }
 @State var loadstate = loadingState.success
 var body: some View{
 Group{
 if loadstate == .loading{
 LoadingView()
 }
 else if loadstate == .success{
 SuccessView()
 }
 else if loadstate == .failed{
 FailedView()
 }
 }
 }
 }
 
 struct LoadingView: View {
 var body: some View{
 Text("loading")
 }
 }
 
 struct SuccessView: View {
 var body: some View{
 Text("success")
 }
 }
 
 struct FailedView: View {
 var body: some View{
 Text("failed")
 }
 }
 */

/* Communicating with a MapKit coordinator
 struct ContentView: View {
 @State var isUnlocked = false
 var body: some View{
 MapView()
 .edgesIgnoringSafeArea(.all)
 }
 }
 */

// Using TouchID and FaceID with SwiftUI
 
struct ContentView: View{
    @State var isUnlocked = false
    var body: some View{
        VStack{
            if isUnlocked{
                Text("Unlocked")
            }
            else{
                Text("Locked")
            }
        }
        .onAppear(perform: authenticate)
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        // check whether biometric authentication is possible
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            // it's possible, so go ahead and use it
            let reason = "We need to unlock your data."
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                // authentication has now completed
                DispatchQueue.main.async {
                    if success {
                        isUnlocked = true
                    } else {
                        // there was a problem
                    }
                }
            }
        } else {
            // no biometrics
        }
        
    }
}
 


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  ContentView.swift
//  SortAndFilter
//
//  Created by Xun Ruan on 2021/7/31.
//

import SwiftUI



struct DirectSort: View {
    var arr = [2,1,5,3,4]
    var sortedArr: [Int]{
        arr.sorted()
    }
    var sortedArr2: [Int]{
        arr.sorted{
            $0 > $1
        }
    }
    
    var body: some View {
        VStack{
            
            ForEach(0..<sortedArr2.count){
                Text("\(sortedArr2[$0])")
            }
        }
    }
}


struct User: Identifiable{
    let id = UUID()
    var firstName: String? = nil
    var lastName: String? = nil
    var age: Int? = nil
    var country: String? = nil
}

class DataCollection: ObservableObject{
    private var users: [User]
    @Published var userDisplayedMode: [User]
    
    init(users: [User]) {
        self.users = users
        self.userDisplayedMode = users
    }
    
    func setToDataDefault(){
        userDisplayedMode = users
    }
}

struct ContentView: View{
    @StateObject var dataCollection = DataCollection(users:[
        User(firstName: "Xun", lastName: "Ruan", age: 10, country: "Canada"),
        User(firstName: "Yuanyan", lastName: "Wen", age: 25, country: "China")
    ])
    @State var isShowingFilterView = false
    var body: some View{
        NavigationView{
            VStack{
                Form{
                    ForEach(dataCollection.userDisplayedMode){ user in
                        Text("\(user.firstName!) \(user.lastName!)")
                    }
                }
            }
            .navigationBarItems(leading: Button("Filter"){
                isShowingFilterView = true
            })
        }
        .sheet(isPresented: $isShowingFilterView){
            FilterView()
                .environmentObject(dataCollection)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  EditView.swift
//  RememberNameBetter
//
//  Created by Xun Ruan on 2021/7/18.
//

import SwiftUI

struct EditView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var firstName = ""
    @State var lastName = ""
    @Binding var picture: Image?
    var body: some View {
        NavigationView{
            VStack{
                picture?
                    .resizable()
                    .scaledToFit()
                Form{
                    TextField("First name: ", text: $firstName)
                    TextField("Last name: ", text: $lastName)
                }
            }
            .navigationBarTitle(Text("About this guy"))
            .navigationBarItems(trailing: Button("Done"){
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(picture: .constant(Image(systemName: "plus")))
    }
}

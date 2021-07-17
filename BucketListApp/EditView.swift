//
//  EditView.swift
//  BucketListApp
//
//  Created by Xun Ruan on 2021/7/17.
//

import SwiftUI
import MapKit

struct EditView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var placeMark: MKPointAnnotation
    var body: some View {
        NavigationView{
            Form{
                Section{
                    TextField("Title", text: $placeMark.wrappedTitle)
                    TextField("Subtitle", text: $placeMark.wrappedSubtitle)
                }
            }
            .navigationBarTitle(Text("Edit place"))
            .navigationBarItems(trailing: Button("Done"){
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(placeMark: MKPointAnnotation.example)
    }
}

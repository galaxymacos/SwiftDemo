//
//  ContentView.swift
//  BucketListApp
//
//  Created by Xun Ruan on 2021/7/16.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State var centerCoordinate = CLLocationCoordinate2D()
    @State var locations = [MKPointAnnotation]()
    @State var selectedPlace: MKPointAnnotation? = nil
    @State var showPlaceDetail: Bool = false
    @State var showingEditScreen: Bool = false
    var body: some View {
        ZStack{
            MapView(centerCoordinate: $centerCoordinate,selectedPlace: $selectedPlace, showPlaceDetail: $showPlaceDetail, annotations: locations)
            Circle()
                .fill(Color.blue)
                .opacity(0.5)
                .frame(width: 32, height: 32, alignment: .center)
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    Button(action: {
                        showingEditScreen = true
                        
                        let newLocation = MKPointAnnotation()
                        
                        // Pin won't show detail view if we don't tell it the title
                        newLocation.title = "Example Location"
                        newLocation.coordinate = centerCoordinate
                        locations.append(newLocation)
                        selectedPlace = newLocation
                        showingEditScreen = true
                    }){
                        Image(systemName: "plus")
                    }
                    .padding()
                    .background(Color.black.opacity(0.75))
                    .foregroundColor(.white)
                    .font(.title)
                    .clipShape(Circle())
                    .padding([.trailing, .bottom])
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
        .alert(isPresented: $showPlaceDetail, content: {
            Alert(title: Text(selectedPlace?.title ?? "No title"), message: Text(selectedPlace?.subtitle ?? "No information"), primaryButton: .default(Text("OK")), secondaryButton: .default(Text("Edit")){
                showingEditScreen = true
            })
        })
        .sheet(isPresented: $showingEditScreen, content: {
            if self.selectedPlace != nil {
                EditView(placeMark: self.selectedPlace!)
            }
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// create an extension to MKPointAnnotation to create an example



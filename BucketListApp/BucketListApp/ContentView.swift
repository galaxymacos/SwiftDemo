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
    @State var locations = [CodableMKPointAnnotation]()
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
                        
                        let newLocation = CodableMKPointAnnotation()
                        
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
        .sheet(isPresented: $showingEditScreen, onDismiss: saveData, content: {
            if self.selectedPlace != nil {
                EditView(placemark: self.selectedPlace!)
            }
        })
        .onAppear(perform: loadData)
    }
    
    func getDocumentDirecotry() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func loadData(){
        let filename = getDocumentDirecotry().appendingPathComponent("SavedPlaces")
        do{
            let data = try Data(contentsOf: filename)
            locations = try JSONDecoder().decode([CodableMKPointAnnotation].self, from: data)
        }
        catch{
            print("Unable to load saved data")
        }
    }
    
    func saveData(){
        do{
            let filename = getDocumentDirecotry().appendingPathComponent("SavedPlaces")
            let data = try JSONEncoder().encode(self.locations)
            try data.write(to: filename, options: [.atomicWrite,.completeFileProtection])
        }
        catch{
            print("Unable to save data")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// create an extension to MKPointAnnotation to create an example



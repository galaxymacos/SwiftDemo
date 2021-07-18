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
    @ObservedObject var placemark: MKPointAnnotation
    
    enum LoadingState {
        case loading, loaded, failed
    }
    
    @State private var loadingState:LoadingState = .loading
    @State private var pages = [Page]()    // The wiki pages of this location
    
   
    var body: some View {
        NavigationView{
            Form{
                Section{
                    TextField("Title", text: $placemark.wrappedTitle)
                    TextField("Subtitle", text: $placemark.wrappedSubtitle)
                }
                
                Section{
                    if loadingState == .loaded{
                        List(pages, id: \.pageid){ page in
                            Text(page.title)
                                .font(.headline)
                                // How to get wikipedia's description
                                + Text(page.description).italic()
                            
                        }
                    }
                    else if loadingState == .loading{
                        Text("Loading")
                    }
                    else{
                        Text("failed")
                    }
                }
            }
            .navigationBarTitle(Text("Edit place"))
            .navigationBarItems(trailing: Button("Done"){
                presentationMode.wrappedValue.dismiss()
            })
            .onAppear(perform: fetchNearbyPlaces)
            
        }
    }
    
    func fetchNearbyPlaces() {
        let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(placemark.coordinate.latitude)%7C\(placemark.coordinate.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"

        guard let url = URL(string: urlString) else {
            print("Bad URL: \(urlString)")
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                // we got some data back!
                let decoder = JSONDecoder()

                if let items = try? decoder.decode(Result.self, from: data) {
                    // success – convert the array values to our pages array
                    self.pages = Array(items.query.pages.values).sorted()
                    self.loadingState = .loaded
                    return
                }
            }

            // if we're still here it means the request failed somehow
            self.loadingState = .failed
        }.resume()
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(placemark: MKPointAnnotation.example)
    }
}

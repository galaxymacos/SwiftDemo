//
//  MapView.swift
//  BucketListApp
//
//  Created by Xun Ruan on 2021/7/16.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable{
    @Binding var centerCoordinate: CLLocationCoordinate2D
    @Binding var selectedPlace: MKPointAnnotation?
    @Binding var showPlaceDetail: Bool
    var annotations: [MKPointAnnotation]
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        return mapView
    }
    // Callback function - when anything being sent to UIViewRepresentabel struct is changed
    func updateUIView(_ uiView: UIViewType, context: Context) {
        print("Updating UIView")
        if annotations.count != uiView.annotations.count{
            uiView.removeAnnotations(uiView.annotations)
            uiView.addAnnotations(annotations)
        }
    }
    
    
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        let parent: MapView
        init(_ parent: MapView) {
            self.parent = parent
        }
        
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            parent.centerCoordinate = mapView.centerCoordinate
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let identifier = "Placemark"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            if annotationView == nil{
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView?.canShowCallout = true
                annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
                
            }
            else{
                annotationView?.annotation = annotation
            }
            return annotationView
        }
        
        // Callback - when a UIControl(here is a UIButton) is tapped
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            guard let placeMark = view.annotation as? MKPointAnnotation else {return}
            parent.selectedPlace = placeMark
            parent.showPlaceDetail = true
        }
    }
}

extension MKPointAnnotation{
    static var example: MKPointAnnotation{
        let point = MKPointAnnotation()
        point.coordinate = CLLocationCoordinate2D(latitude: 51.5, longitude: -0.13)
        point.title = "London"
        point.subtitle = "The home of 2012 Summer Olympics"
        return point
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(centerCoordinate: .constant(MKPointAnnotation.example.coordinate), selectedPlace: .constant(MKPointAnnotation.example), showPlaceDetail: .constant(false), annotations: [MKPointAnnotation.example])
            }
}

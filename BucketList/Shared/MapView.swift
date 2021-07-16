//
//  MapView.swift
//  BucketList (iOS)
//
//  Created by Xun Ruan on 2021/7/16.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    func makeUIView(context: Context) -> some UIView {
        let mapView = MKMapView()
        return mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}

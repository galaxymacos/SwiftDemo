//
//  LocationFetcher.swift
//  LocationFetcher
//
//  Created by Xun Ruan on 2021/7/19.
//

import CoreLocation

class LocationFetcher: NSObject, CLLocationManagerDelegate{
    let manager = CLLocationManager()
    var lastKnownLocation: CLLocationCoordinate2D?
    
    override init() {
        super.init()
        manager.delegate = self
    }
    
    func Start(){
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastKnownLocation = locations.first?.coordinate
    }
}

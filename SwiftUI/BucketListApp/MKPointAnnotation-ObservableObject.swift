//
//  MKPointAnnotation-ObservableObject.swift
//  BucketListApp
//
//  Created by Xun Ruan on 2021/7/17.
//

import MapKit
extension MKPointAnnotation: ObservableObject{
    public var wrappedTitle: String{
        get{
            return title ?? "No title"
        }
        set{
            title = newValue
        }
    }
    
    public var wrappedSubtitle: String{
        get{
            return subtitle ?? "No subtitle"
        }
        set{
            subtitle = newValue
        }
    }
}

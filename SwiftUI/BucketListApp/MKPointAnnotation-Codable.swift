//
//  MKPointAnnotation-Codable.swift
//  BucketListApp
//
//  Created by Xun Ruan on 2021/7/17.
//

import MapKit

// How to make MKPointAnnotation codable and save our user prefered place
class CodableMKPointAnnotation: MKPointAnnotation, Codable{
    
    enum CodingKeys: CodingKey{
        case title, subtitle, latitude, longitude
    }
    
    override init() {
        super.init()
    }
    
    public required init(from decoder: Decoder) throws {
        super.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        subtitle = try container.decode(String.self, forKey: .subtitle)
        
        let latitude = try container.decode(Double.self, forKey: .latitude)
        let longitude = try container.decode(Double.self, forKey: .longitude)
        
        coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(subtitle, forKey: .subtitle)
        try container.encode(coordinate.longitude, forKey: .longitude)
        try container.encode(coordinate.latitude, forKey: .latitude)
    }
}

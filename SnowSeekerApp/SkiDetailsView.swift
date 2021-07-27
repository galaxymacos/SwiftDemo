//
//  SkiDetailsView.swift
//  SnowSeekerApp
//
//  Created by Xun Ruan on 2021/7/27.
//

import SwiftUI

struct SkiDetailsView: View {
    let resort: Resort
    
    var body: some View {
        VStack{
            Text("Elevation: \(resort.elevation)m")
            Text("Snow depth: \(resort.snowDepth)cm")
        }
    }
}

struct SkiDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        SkiDetailsView(resort: Resort.example)
    }
}

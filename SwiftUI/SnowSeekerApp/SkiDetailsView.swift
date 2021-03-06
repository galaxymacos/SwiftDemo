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
        Group{
            // Text should not be hidden or pushed to wrap by Spacer()
            Text("Elevation: \(resort.elevation)m").layoutPriority(1)
            Spacer().frame(height: 0)
            Text("Snow depth: \(resort.snowDepth)cm").layoutPriority(1)
        }
    }
}

struct SkiDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        SkiDetailsView(resort: Resort.example)
    }
}

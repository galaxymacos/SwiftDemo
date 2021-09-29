//
//  EmbossyButton.swift
//  UIDesign-Button
//
//  Created by 阮迅 on 2021-09-28.
//

import SwiftUI

struct EmbossedButtonStyle : ButtonStyle {
    enum ButtonShape {
        case capsule, round
    }
    
    var buttonShape = ButtonShape.capsule
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(10)
            .background(    // MARK: The background's frame is tightly around the label
                GeometryReader { geometry in
                    shape(size: geometry.size)
                        .shadow(color: .gray, radius: 1, x: 2, y: 2)    // MARK: Add shadow around the stroke
                        .shadow(color: .white, radius: 1, x: -2, y: -2)
                        .offset(x: -1, y: -1)   // MARK: When stroking, we need to offset the stroke to the half of the 
                    
                }
            )
    }
    
    @ViewBuilder
    func shape(size: CGSize) -> some View {
        switch buttonShape {
        case .capsule:
            Capsule()
                .stroke(Color.white, lineWidth: 2)  // MARK: .stroke only work on shape, not any "some View", so it needs to bind here
        case .round:
            Circle()
                .stroke(Color.white, lineWidth: 2)
                .frame(width: max(size.width, size.height), height: max(size.width, size.height))
                .offset(y: -max(size.width, size.height) / 2 +
                  min(size.width, size.height) / 2)
                
        }
    }
    
}



struct EmbossyButton_Previews: PreviewProvider {
    static var previews: some View {
        
        ZStack {
            Button(action: {}) {
                Text("Embossed")
            }
            .buttonStyle(EmbossedButtonStyle(buttonShape: .round))
        }
        .padding(50)
        .previewLayout(.sizeThatFits)
        
        
    }
}

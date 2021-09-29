//
//  RaisedButton.swift
//  UIDesign-Button
//
//  Created by 阮迅 on 2021-09-28.
//

import SwiftUI

struct RaisedButton: View {
    var buttonText: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(buttonText)
                .raiseButtonTextStyle()
        }
        .buttonStyle(RaisedButtonStyle())
    }
}

extension Text {
    func raiseButtonTextStyle() -> some View {
        self
            .font(.body)
            .fontWeight(.bold)
    }
}

struct RaisedButtonStyle : ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding([.top, .bottom], 12)
            .background(
                Capsule()
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 4, x: 6, y: 6)
                    .shadow(color: .gray, radius: 4, x: -6, y: -6)
            )
    }
}

struct RaisedButton_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            RaisedButton(buttonText: "Raised Button", action: {})
                .padding()
        }
        .background(Color.white)
        .previewLayout(.sizeThatFits)
    }
}

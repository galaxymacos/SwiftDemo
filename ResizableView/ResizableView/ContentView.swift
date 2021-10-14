//
//  ContentView.swift
//  ResizableView
//
//  Created by 阮迅 on 2021-09-30.
//

import SwiftUI
import Foundation

struct ContentView: View {
    @State var transform = Transform()
    @State var dragOffset: CGSize = .zero   // MARK: The offset will be nonzero when dragging
    @State var rotationOffset: Angle = .zero
    @State var scaleOffset: CGFloat = 1
    
    var body: some View {
        let rotationGesture: _EndedGesture<_ChangedGesture<RotationGesture>> = RotationGesture()
            .onChanged({ angle in
                rotationOffset = angle
            })
            .onEnded({ angle in
                transform.rotation = transform.rotation + rotationOffset
                rotationOffset = .zero
            })
        let scaleGesture: _EndedGesture<_ChangedGesture<MagnificationGesture>> = MagnificationGesture()
            .onChanged({ scale in
                scaleOffset = scale
            })
            .onEnded({ scale in
                transform.size.width *= scale
                transform.size.height *= scale
                scaleOffset = 1
            })
        RoundedRectangle(cornerRadius: 30)
            .frame(width: transform.size.width, height: transform.size.height)
            .foregroundColor(.red)
            .rotationEffect(transform.rotation + rotationOffset)
            .offset(x: transform.offset.width + dragOffset.width, y: transform.offset.height + dragOffset.height)   // MARK: The offset of the view is controlled by its current offset, and the offset that's brought by the drag gesture
            .scaleEffect(scaleOffset)
            .gesture(DragGesture()
                        .onChanged({ value in
                dragOffset = value.translation  // MARK: Add to the its current dragOffset
            })
                        .onEnded({ value in
                transform.offset = transform.offset + dragOffset    // MARK: Put all its current drag offset to the size's offset
                dragOffset = .zero //  // MARK: clear the dragOffset because user is no longer dragging
            }))
            .gesture(SimultaneousGesture(rotationGesture, scaleGesture))    // MARK: Because two gestures are indistinguishable, meaning that when user put two fingers on the screen, we don't use if he is doing the rotation gesture or magnification gesture, so we process both
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

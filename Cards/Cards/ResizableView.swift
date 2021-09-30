//
//  ResizableView.swift
//  Cards
//
//  Created by 阮迅 on 2021-09-29.
//

import SwiftUI

struct ResizableView: ViewModifier {
//    let content = RoundedRectangle(cornerRadius: 30)
//    let color = Color.red
    @State private var transform = Transform()
    @State private var previousOffset: CGSize = .zero
    @State private var previousRotation: Angle = .zero
    @State private var angle: Angle = .zero
    @State private var scale: CGFloat = 1

    
    func body(content: Content) -> some View {
        
            let dragGesture = DragGesture()
                .onChanged({ value in
                    transform.offset = value.translation + previousOffset
                })
                .onEnded({ value in
                    previousOffset = transform.offset
                })
            let rotationGesture = RotationGesture()
                .onChanged { angle in
                    transform.rotation += angle - previousRotation
                    previousRotation = angle
                    self.angle = angle
                }
                .onEnded({ angle in
                    
                    previousRotation = .zero
                })
            let scaleGesture = MagnificationGesture()
                .onChanged({ scale in
                    self.scale = scale
                })
                .onEnded({ scale in
                    self.transform.size.width *= scale
                    self.transform.size.height *= scale
                    self.scale = 1
                })
            
            content
                .frame(width: transform.size.width, height: transform.size.height)
                .rotationEffect(transform.rotation)
                .scaleEffect(scale)
                .offset(transform.offset)
                .gesture(dragGesture)
                .gesture(SimultaneousGesture(rotationGesture, scaleGesture))
           
            
    }
}

struct ResizableView_Previews: PreviewProvider {
    static var previews: some View {
        RoundedRectangle(cornerRadius: 25)
            .foregroundColor(.red)
            .modifier(ResizableView())
    }
}

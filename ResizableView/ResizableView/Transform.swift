//
//  Transform.swift
//  ResizableView
//
//  Created by 阮迅 on 2021-09-30.
//

import SwiftUI

// MARK: Store the size of the view
struct Transform {
    var size: CGSize = CGSize(width: 250, height: 180)
    var offset: CGSize = .zero
    var rotation: Angle = .zero
}

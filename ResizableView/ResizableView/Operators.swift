//
//  Operators.swift
//  ResizableView
//
//  Created by 阮迅 on 2021-09-30.
//

import SwiftUI


func + (left: CGSize, right: CGSize)->CGSize {
    return CGSize(width: left.width + right.width, height: left.height + right.height)
}

func * (left: CGSize, right: CGFloat)->CGSize {
    return CGSize(width: left.width * right, height: left.height * right)
}


//
//  Operators.swift
//  Cards
//
//  Created by 阮迅 on 2021-09-29.
//

import SwiftUI

func +(left: CGSize, right: CGSize) -> CGSize {
    return CGSize(width: left.width + right.width, height: left.height + right.height)
}

//
//  ViewExtensions.swift
//  Cards
//
//  Created by 阮迅 on 2021-09-30.
//

import SwiftUI

extension View {
    func resizableView() -> some View {
        self
            .modifier(ResizableView())
    }
}

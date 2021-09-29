//
//  CardBottomToolbar.swift
//  Cards
//
//  Created by 阮迅 on 2021-09-29.
//

import SwiftUI

struct ToolbarButtonView: View {
    let model: CardModel
    private var modalButton: [CardModel: (text: String, imageName: String)] = [
        .photoPicker: ("Photos", "photo"),
        .framePicker: ("Frames", "square.on.circle"),
        .stickerPicker: ("Stickers", "heart.circle"),
        .textPicker: ("Text", "textformat")
    ]
    
    init(model: CardModel) {
        self.model = model
    }
    var body: some View {
        if let text = modalButton[model]?.text,
           let imageName = modalButton[model]?.imageName {
            VStack {
                Image(systemName: imageName)
                    .font(.largeTitle)
                Text(text)
            }
            .padding(.top)
            
        }
    }
}

struct CardBottomToolbar: View {
    @Binding var cardModel: CardModel
    var body: some View {
        HStack {
            Button(action: {cardModel = .photoPicker}) {
                ToolbarButtonView(model: .photoPicker)
            }
            Button(action: {cardModel = .framePicker}) {
                ToolbarButtonView(model: .framePicker)
            }
            Button(action: {cardModel = .stickerPicker}) {
                ToolbarButtonView(model: .stickerPicker)
            }
            Button(action: {cardModel = .textPicker}) {
                ToolbarButtonView(model: .textPicker)
            }
        }
    }
}

struct CardBottomToolbar_Previews: PreviewProvider {
    static var previews: some View {
        CardBottomToolbar(cardModel: .constant(.stickerPicker))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}

//
//  CardDetailView.swift
//  Cards
//
//  Created by 阮迅 on 2021-09-29.
//

import SwiftUI

struct CardDetailView: View {
    @EnvironmentObject var viewState: ViewState
    @State var currentModal = CardModel.stickerPicker
    
    var content: some View {
        ZStack {
            Capsule()
                .foregroundColor(.yellow)
                .resizableView()
            Text("Please resize me")
                .fontWeight(.bold)
                .font(.system(size: 500))   // MARK: Different than shape, font is controlled directly by font (Even the frame is very big, if the font is small, then the Text is small)
                .minimumScaleFactor(0.01)
                .lineLimit(1)
                .resizableView()
            Circle()
                .resizableView()
                .offset(CGSize(width: 50, height: 200))
        }
    }
    
    var body: some View {
        content
            .toolbar {  // MARK: for toolbar to show up, it needs to be in a NavigationView
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {viewState.showAllCards.toggle()}) {
                        Text("Done")
                    }
                }
                ToolbarItem(placement: .bottomBar) {
                    CardBottomToolbar(cardModel: $currentModal)
                }
            }
        
    }
}


struct CardDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CardDetailView()
            .environmentObject(ViewState())
    }
}
